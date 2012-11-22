# Gitolite.todo

- Make it possible to specify a revision to checkout @na

## Specific Revision

I think this can be accomplished by passing another paramter to `class gitolite` which is used in an update `Exec` which checks out the specific revision and notifies `Exec["Install Gitolite"]`. The notify is important because that will regenerate the `VERSION` file gitolite needs.