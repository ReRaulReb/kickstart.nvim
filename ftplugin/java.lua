local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then return end

local mason_registry = require('mason-registry')
local jdtls_pkg = mason_registry.get_package('jdtls')
local jdtls_path = jdtls_pkg:get_install_path()

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

local os_config = 'linux'

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', jdtls_path .. '/config_' .. os_config,
    '-data', workspace_dir,
  },

  root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }, { upward = true })[1]),

  settings = {
    java = {},
  },

  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
