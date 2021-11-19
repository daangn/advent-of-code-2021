{application, 'helloworld', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['helloworld_app','helloworld_sup']},
	{registered, [helloworld_sup]},
	{applications, [kernel,stdlib]},
	{mod, {helloworld_app, []}},
	{env, []}
]}.