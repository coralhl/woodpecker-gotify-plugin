# Woodpecker Gotify Plugin
A very simple [Woodpecker](https://woodpecker-ci.org) plugin to send a notification to [Gotify](https://gotify.net).

## Notes
I recommend having different steps for success/failure, as the plugin does not seem to be aware of the previous step, so CI_PIPELINE_STATUS seems to always be "success"?

You can use Woodpecker [variables](https://woodpecker-ci.org/docs/usage/environment) in `message`

## Usage
```yaml
---
steps:
- name: Some Script
  image: some/plugin

- name: Gotify Success Notification
  image: coralhl/woodpecker-gotify-plugin
  settings:
    token:
      from_secret: gotify_token
    gotify_url: 'https://gotify.myawesomedomain.com'
    # title is optional
    title: Notification from my Pipeline
    # priority is optional, defaults to 5
    priority: 9
    # message is optional
    message: Success!
  when:
    - status: [ success ]

- name: Gotify Failure Notification
  image: coralhl/woodpecker-gotify-plugin
  settings:
    token:
      from_secret: gotify_token
    gotify_url: 'https://gotify.myawesomedomain.com'
    # title is optional
    title: Notification from my Pipeline
    # priority is optional, defaults to 5
    priority: 9
    # message is optional
    message: Failure!
  when:
    - status: [ failure ]
```
