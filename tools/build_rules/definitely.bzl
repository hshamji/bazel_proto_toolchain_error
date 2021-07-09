def definitely(fn, name, **kwargs):
    """
    Bazel macro to ensure that rules are really loaded and not shadowed by
    other workspace imports.

    If loading a repository via definitely fails, reorder the WORKSPACE so this
    dependency comes before any other loads of the same repository.
    Arguments:
        fn: repository rule function.
        name: name of the repository to create.
        **kwargs: remaining arguments that are passed to the fn function.
    """
    if native.existing_rule(name):
        fail("%s already defined: %s" % (name, native.existing_rule(name)))
    fn(name = name, **kwargs)
