<!--
.. title: Ansible ZFS Bug For Solaris
.. slug: ansible-zfs-bug-for-solaris
.. date: 2016-09-12 22:28:56 UTC
.. tags: ansible, solaris, omnios, zfs
.. link:
.. description:
.. type: text
-->

While updating Ansible I ran into an issue with an extras module for ZFS and
Solaris. A playbook that used to work to set a mount point no longer worked. I
was seeing errors that ended in

```
if int(version) >= 34:\r\nValueError: invalid literal for int() with base 10: '-'\r\n", "msg": "MODULE FAILURE"
```

An [issue was
filed](https://github.com/ansible/ansible-modules-extras/issues/2415) in June
and fixed last month. This change isn't in the latest Ansible 2.1.1.0 which I
was using. For the time being I've added the
[extras](https://github.com/ansible/ansible-modules-extras) repository devel
branch as a submodule and used `ANSIBLE_LIBRARY=...` to get a fixed version.
