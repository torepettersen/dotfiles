use serde::Deserialize;
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io::Error;
use std::io::ErrorKind;
use std::io::Result;
use std::os::unix::fs::symlink;
use std::path::Path;
use std::path::PathBuf;

#[derive(Debug, Deserialize)]
struct Config {
    links: HashMap<String, Link>,
}

#[derive(Debug, Deserialize)]
struct Link {
    source: String,
    target: String,
}

fn find_base_dir() -> Result<PathBuf> {
    let cwd = env::current_dir()?;
    let mut candidates = vec![cwd.clone()];
    if let Some(parent) = cwd.parent() {
        candidates.push(parent.to_path_buf());
    }

    for dir in candidates {
        if dir.join("dotlink.toml").exists() {
            return Ok(dir);
        }
    }

    Err(Error::new(
        ErrorKind::NotFound,
        "⚠️ Could not find dotlink.toml (looked in . and ..)",
    ))
}

fn link(base_dir: &Path, source: &str, target: &str) -> Result<()> {
    let src_path = base_dir.join(source);
    let tgt = shellexpand::tilde(target).into_owned();
    let tgt_path = Path::new(&tgt);

    if tgt_path.symlink_metadata().is_ok() {
        println!("🔁 Replacing existing {}", tgt);
        fs::remove_dir_all(&tgt)?;
    }

    println!("🔗 Linking {:?} → {}", src_path, tgt);
    symlink(&src_path, &tgt)?;
    Ok(())
}

fn main() -> Result<()> {
    let base_dir = find_base_dir()?;
    let config_path = base_dir.join("dotlink.toml");

    let config_str = fs::read_to_string(&config_path).expect("⚠️ Failed to read dotlink.toml");
    let config: Config = toml::from_str(&config_str).expect("Invalid TOML format");

    for (name, item) in &config.links {
        println!("➡️ Setting up {}", name);
        link(&base_dir, &item.source, &item.target)?;
    }

    println!("✅ Done!");
    Ok(())
}
