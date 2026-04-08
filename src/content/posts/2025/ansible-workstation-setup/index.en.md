---
title:  "Ansible Workstation Setup: Automating Your Linux Environment"
date:   2025-02-21
#description: "..."
image: images/robots2.jpg
imageAltAttribute: Ansible Workstation Setup
tags: 
  - Automation
  - Linux
  - Ansible
  - Pop OS
permalink: '/2025/02/21/ansible-workstation-setup'
---

In the world of IT, efficiency is key. Ansible, a powerful automation tool, allows us to create reproducible workflows using simple YAML files. This article focuses on how to use Ansible for the automatic installation and configuration of a Linux system.

## The Core Idea: If You Do It More Than Once, Automate It

Why should you automate your PC installation? Beyond the fun and challenge of doing it with Ansible, it's about the fundamental idea that any task you perform more than once should be automated, documented, and reproducible.

Importantly, this Ansible playbook goes beyond just installing software packages. I've attempted to capture as much configuration and customization in Ansible as possible. This includes:

- Desktop customization like the arrangement of my dock including all applications, background image, and custom keyboard shortcuts
- Installation of Google Chrome extensions, start pages, and other configurations
- Visual Studio Code with all extensions
- Unified folder structure

If you're curious, you can check out my public playbook on [GitHub](https://github.com/christophdb/ansible-workstation-init).

## Synchronizing My Workspaces

For years, my notebook was my constant companion. It had everything I needed, and I was always ready to work. Subconsciously, I always had a small worry about losing my notebook and only then realizing that something was missing.

Building my setup with Ansible forced me to carefully consider what I really needed. One realization was that I hadn't properly secured an SSH key created specifically for one application. While this wouldn't have been an unsolvable problem, it would have been annoying.

## Prerequisite: Cloud-Based Data Storage

To quickly become operational again and to truly benefit from this approach, you should already have your data stored in the cloud (public or private). This makes things significantly easier.

For me, it's set up as follows:

- All my files are in a private or professional Seafile server instance
- My emails, contacts, and appointments are on a mail server
- Most of my development work is on GitHub or a private Gitea
- I try to develop Docker containers for various development projects that provide everything necessary


## What This Means in Practice

When I install a new notebook, for example, it involves the following steps:

1. Installation of the Linux operating system (Pop OS or Ubuntu)
2. Installation of Ansible
3. Execution of the Ansible playbook with ansible-pull
4. Setting up Thunderbird
5. Setting up my file synchronization with the Seafile servers
6. Retrieving my SSH keys, Wireguard, and OpenVPN configuration files

In total, it takes me less than an hour to be fully operational again.

## Summary

Beyond the fun of the challenge, I believe every Linux desktop user should create their own Ansible playbook.

To conclude, here are the advantages I see:

- Documentation of my Linux work environment with all tools, configurations, and customizations
- Quickly operational again in case of loss or damage
- Synchronization of work environments between notebook and workstation
- Installation of a temporary travel notebook
- Fresh installation of a new operating system version instead of operating system upgrades

Automating your PC setup with Ansible not only saves time but also ensures consistency across your machines and provides peace of mind. It's an investment that pays off in the long run, making you more efficient and your setup more robust.
