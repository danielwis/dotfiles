return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' },
  settings = {
    bashIde = {
      shfmt = {
        languageDialect = "auto",
        simplifyCode = true,
        caseIndent = true,
        binaryNextLine = true,
      },
    },
  },
}
