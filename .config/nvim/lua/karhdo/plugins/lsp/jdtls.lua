return {
	'mfussenegger/nvim-jdtls',
	ft = 'java',
	config = function()
		local jdtls = require('jdtls')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local mason_pkg = vim.fn.stdpath('data') .. '/mason/packages/jdtls'

		local os_config = (function()
			if vim.fn.has('mac') == 1 then
				return vim.loop.os_uname().machine == 'arm64' and 'config_mac_arm' or 'config_mac'
			elseif vim.fn.has('unix') == 1 then
				return 'config_linux'
			end
			return 'config_win'
		end)()

		local launcher_jar = vim.fn.glob(mason_pkg .. '/plugins/org.eclipse.equinox.launcher_*.jar')
		local lombok_jar = mason_pkg .. '/lombok.jar'
		local config_dir = mason_pkg .. '/' .. os_config

		local root_markers = { 'gradlew', 'mvnw', 'settings.gradle', 'settings.gradle.kts', 'pom.xml', '.git' }
		local root_dir = vim.fs.root(0, root_markers)

		local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ':t')
		local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

		local config = {
			cmd = {
				'java',
				'-Declipse.application=org.eclipse.jdt.ls.core.id1',
				'-Dosgi.bundles.defaultStartLevel=4',
				'-Declipse.product=org.eclipse.jdt.ls.core.product',
				'-Dlog.protocol=true',
				'-Dlog.level=ALL',
				'-Xmx4g',
				'--add-modules=ALL-SYSTEM',
				'--add-opens',
				'java.base/java.util=ALL-UNNAMED',
				'--add-opens',
				'java.base/java.lang=ALL-UNNAMED',
				'-javaagent:' .. lombok_jar,
				'-jar',
				launcher_jar,
				'-configuration',
				config_dir,
				'-data',
				workspace_dir,
			},
			root_dir = root_dir,
			capabilities = capabilities,
			settings = {
				java = {
					eclipse = { downloadSources = true },
					-- Prefer Gradle (build.gradle.kts) over Maven when a repo ships both
					import = {
						gradle = { enabled = true },
						maven = { enabled = false },
					},
					maven = { downloadSources = true },
					signatureHelp = { enabled = true },
					contentProvider = { preferred = 'fernflower' },
					completion = {
						favoriteStaticMembers = {
							'org.hamcrest.MatcherAssert.assertThat',
							'org.hamcrest.Matchers.*',
							'org.hamcrest.CoreMatchers.*',
							'org.junit.jupiter.api.Assertions.*',
							'java.util.Objects.requireNonNull',
							'java.util.Objects.requireNonNullElse',
							'org.mockito.Mockito.*',
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
					codeGeneration = {
						toString = {
							template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
						},
						useBlocks = true,
					},
					configuration = {
						runtimes = {
							{ name = 'JavaSE-21', path = vim.fn.trim(vim.fn.system('/usr/libexec/java_home -v 21')) },
						},
					},
				},
			},
			init_options = {
				bundles = {},
			},
		}

		local start = function()
			jdtls.start_or_attach(config)
		end

		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'java',
			callback = start,
		})

		start()

		vim.api.nvim_create_user_command('JdtlsOrganizeImports', function()
			jdtls.organize_imports()
		end, {})
		vim.api.nvim_create_user_command('JdtlsExtractVariable', function()
			jdtls.extract_variable()
		end, { range = true })
		vim.api.nvim_create_user_command('JdtlsExtractMethod', function()
			jdtls.extract_method(true)
		end, { range = true })
	end,
}
