function fix-nexus --description "Update Nexus's dependencies when a compile fails"
    OSTYPE=linux-gnu tools/ci_download_dendrite_stub
    OSTYPE=linux-gnu tools/ci_download_maghemite_mgd

    # Add these to the path
    set -gx DENDRITE_BIN_DIR /Users/just-be/Oxide/omicron/out/dendrite-stub/bin
    set -gx MGD_BIN_DIR /Users/just-be/Oxide/omicron/out/mgd/root/opt/oxide/mgd/bin

    readenv tools/dendrite_openapi_version
    set -l DENDRITE_COMMIT "$COMMIT"

    readenv tools/maghemite_mg_openapi_version
    set -l MGD_COMMIT "$COMMIT"

    cd ../dendrite
    git fetch && git checkout $DENDRITE_COMMIT
    cargo build -p dpd --release --features=tofino_stub
    cargo build -p swadm --release
    cp target/release/dpd "$DENDRITE_BIN_DIR/dpd"
    cp target/release/swadm "$DENDRITE_BIN_DIR/swadm"
    cd -

    cd ../maghemite
    git fetch && git checkout $MGD_COMMIT
    cargo build -p mgd --release --no-default-features
    cp target/release/mgd "$MGD_BIN_DIR/mgd"
    cd -
end
