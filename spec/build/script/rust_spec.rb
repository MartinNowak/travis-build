require 'spec_helper'

describe Travis::Build::Script::Rust, :sexp do
  let(:data)   { payload_for(:push, :rust) }
  let(:script) { described_class.new(data) }
  subject      { script.sexp }

  it_behaves_like 'compiled script' do
    let(:code) { ['TRAVIS_LANGUAGE=rust'] }
    let(:cmds) { ['cargo build --verbose'] }
  end

  it_behaves_like 'a build script sexp'

  it 'downloads and installs Rust' do
    should include_sexp [:cmd, %r(curl .*dist/rust-nightly.*\.tar\.gz), assert: true, echo: true, timing: true]
  end

  it 'downloads and installs Cargo' do
    should include_sexp [:cmd, %r(curl .*cargo-dist/cargo-nightly.*\.tar\.gz), assert: true, echo: true, timing: true]
  end

  it 'runs cargo build' do
    should include_sexp [:cmd, 'cargo build --verbose', echo: true, timing: true]
  end

  it 'runs cargo test' do
    should include_sexp [:cmd, 'cargo test --verbose', echo: true, timing: true]
  end
end
