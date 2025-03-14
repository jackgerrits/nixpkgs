{ buildGoModule
, fetchFromGitHub
, installShellFiles
, lib
}:
buildGoModule rec {
  pname = "coder";
  version = "0.12.4";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    hash = "sha256-RqdnX0oYUmJAzF3FAKHOUNMY5m8FN63c4Z/VBfJrupI=";
  };

  # integration tests require network access
  doCheck = false;

  vendorHash = "sha256-3SStGCDpo+AS4PM9mbXM0EjsJ/3CVFQyb/NRK9RSZ3A=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd coder \
      --bash <($out/bin/coder completion bash) \
      --fish <($out/bin/coder completion fish) \
      --zsh <($out/bin/coder completion zsh)
  '';

  meta = with lib; {
    description = "Remote development environments on your infrastructure provisioned with Terraform";
    homepage = "https://coder.com";
    license = licenses.agpl3;
    maintainers = with maintainers; [ urandom ];
  };
}
