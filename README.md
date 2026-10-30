# Public technical notes

| Topic | Contents |
|---|---|
| [AWX installation](installing_awx/) | Historical installation notes and example manifests |
| [Ansible study notes](redhat_cert_ex294/) | Learning exercises and practice configurations |

These are reference and lab materials, not current production runbooks. Check the recorded versions against current vendor documentation before use. Practice-exam content needs its original attribution and reuse terms checked before redistribution; no official exam affiliation is claimed.

## Credential and lab boundaries

The AWX Secret manifest uses placeholders. Password/key-named fixtures in the practice directories are disposable teaching examples, not credential storage patterns. Never reuse those values in real systems. Supply unique lab credentials privately, and do not commit filled-in manifests, vault unlock files or live inventory.

A Kubernetes Secret manifest does not by itself keep plaintext out of Git. Real passwords, keys and tenant/customer details belong outside this public repository.

The October 2026 repository review was static. No AWX installation, live credential validation or exam-environment test was performed.
