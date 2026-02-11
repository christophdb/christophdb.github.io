---
title: "protect pages with mtls"
date: 2020-09-10
draft: true
nosearch: true
---

Motivation:
- Basicauth ist mist, IP-Einschränkung ist mist.
- Login alleine ist vielleicht nicht genug (selbst mit saml oder sso)
- wenn teilnehmerkreis klein und clients nur browser bzw. mobile devides der anwender sind, dann ist es machbar (nicht z.B. teleport)

Clients brauchen Zertifikat, um Server anzuzeigen
Zertifikatmanagement mit vaultls (container)
Einbinden per Caddy ist super simple:
Zertifikat zu den Clients bringen