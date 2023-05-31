function build-dpd --description "Build dendrite for Oxide's control plane"
  OSTYPE=linux-gnu tools/ci_download_dendrite_stub

  set -l BIN_DIR "/Users/just-be/Oxide/omicron/out/dendrite-stub/root/opt/oxide/dendrite/bin"

  cd /Users/just-be/Oxide/dendrite
  git pull
  cargo build -p dpd --features tofino_stub --release
  cargo build -p swadm --release
  cp target/release/dpd "$BIN_DIR/dpd"
  cp target/release/swadm "$BIN_DIR/swadm"
  cd ../omicron
end