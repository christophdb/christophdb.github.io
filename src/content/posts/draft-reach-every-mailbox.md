---
title:  "Reach every mailbox"
date:   2025-02-01
description: "..."
#image: images/ai-powered-knowledge-management-private-data.png
#imageAltAttribute: Ansible Workstation Setup
tags:
  - email
  - self-hosted
  - n8n
  - privacy
#permalink: '/2025/03/21/ai-powered-knowledge-management'
draft: true
nosearch: true
---

## E-Mails müssen funktionieren

E-Mail ist auch im Jahre 2026 eines der entscheidensten Kommunikationskanäle:
- Anmeldungsinformation nach der Registrierung
- Support-Anfragen und Antworten
- Rechnungen
- sonstige Kommunikation

All das läuft über E-Mails und wenn E-Mails mal nicht zugestellt werden können, ist das katastrophal. Die meisten Firmen begeben sich in die Hände einer der großen Mailinganbieter: Microsoft, Amazon oder Google um keinen Aufwand zu haben und um das Risiko zu minieren, dass man auf einer Spamliste landet. 

Für meine Firma kam das nicht in Frage. Wir wollten unsere E-Mailpostfächer unter Kontrolle haben und die E-Mails entweder selbst oder von einem einem europäischen Anbieter verschicken lassen. Als wir dann auf der Blocklist von Microsoft landete und wir kein E-Mailpostfach von outlook.com, outlook.de, hotmail.com, live.com erreichen konnten, mussten wir uns sehr intensiv mit der Thematik beschäftigen um sicherzustellen, dass wir unsere Changen die Kundenmailbox zu erreichen maximieren und auch frühzeitig mitkriegen, wenn eine Mail nicht ankommt.

Dieser Artikel ist die Summe meiner Erfahrungen aus mindestens einem Monat intensiver Beschäftigung mit dem Thema E-Mail-Delivery. Mit dem Wissen aus diesem Artikel wird die Chance, das gewünschte Postfach der Kunden zu erreichen maximiert und man baut automatismen auf, die einen im Fehlerfall benachrichtigen.

## Unser Setup: lokaler Mailserver plus Brevo

Wie bereits erwähnt, kam die Nutzung von nicht-europäischen Diensten nicht in Frage. Dies führte dazu, dass unsere Infrastruktur nun so aussieht:

- wir betreiben mit Mailcow einen eigenen Mailserver
- wir verschicken alle E-Mails mit Brevo (ehemals sendinblue). 

Wenn ich sage, wir verschicken alles über Brevo ist das auch so gemeint. Dazu gehört:

- Kampagnen, die wir in Brevo planen und dann verschicken
- Automationen, die wir in Brevo angelegt haben
- jede E-Mail, die einer unserer Dienste verschickt, z.B. unser Forum oder unsere Cloud-Platform nutzt das SMTP-Gateway von Brevo
- selbst wenn die Mitarbeiter eine E-Mail über Thunderbird verschicken, dann wird die Mail von Mailcow an Brevo übergeben und von dort verschickt.

Vereinfacht kann man somit sagen:

- eingehend landet alles in einem Postfach von Mailcow
- ausgehende E-Mails werden immer von Brevo verschickt (als Kampagne oder transaktionale E-Mail)

Dabei ist es für den folgenden Artikel nicht von belang, ob man Brevo oder einen anderen Mailanbieter wir Mailjet, CleverReach, MailerLite, Rapidmail, Hubspot, Mailchimp, ActiveCampaign, GetResponse oder sogar nur einen eigenen Mailserver verwendet. 

## Technisches Setup

Wenn man sich ernsthaft mit dem Thema E-Mailversand beschäftigt, wird man sich intensiv mit dem technischen Setup auseinander setzen müssen. In den letzten Jahren wurden viele neue Techniken eingeführt, um das an sich unsichere Protokoll E-Mail sicherer zu machen. Den grundsätzlich hindert einen niemand daran eine E-Mail mit dem Absender steve.jobs@apple.com an jeden beliebigen Empfänger zu schicken. Es ist nur die Frage, was der empfangende Mailserver daraus macht. Im besten fall wird diese E-Mail einfach ignoriert. Die Entscheidung über die vErtrauenswürdigkeit einer E-mail erfolgt durch Techniken wie DKIM, SPF, DMARC und co., die am Ende alle darauf abzielen, dass man Inhaber der absendenden Domain ist und man auch E-Mails für diese Domain verschicken darf.

### Grundsetup ist das Fundament

In diesem Artikel werde ich nicht darauf eingehen, wie man genau DKIM, SPF und DMARC einrichtet. Dafür gibt es mehr als genug Anleitungen. Es ist jedoch von entscheidender Bedeutung, dass man dieses Grundsetup zuverlässig ausführt. Ohne das wird es nicht funktionieren.

### Ohne eigene IP sollte man gar nicht erst anfangen.

Ein weiterer wichtiger Punkt ist eine eigene IP-Adresse. Wenn man sich die Mühe macht, und sich mit dem E-Mailversand intensiver auseinander setzt, dann muss man eine eigene IP-Adresse verwenden. Dies bedeutet entweder ein Mailserver mit fester IP-Adresse oder eine dedizierte IP-Adresse bei Brevo. Wenn man nicht bereit ist, diese Kosten zu tragen, sollte man sich den Aufwand sparen.

### Die Qualität der Empfänger ist entscheidend

Dies bedeutet dann auch, dass die Reputation dieser IP-Adresse ab sofort eine der wichtigsten Aufgaben darstellt. Man kann das beste technische Setup haben, wenn man hauptsächlich an nicht existierende Adressen verschickt und somit hohe Soft- oder Hardbounce Raten hat, wird man keinen Erfolg haben. Dies sollte eine Selbstverständlichkeit sein, aber wird auch nicht teil dieses Artikels sein.

Dieser Artikel fängt also damit an spannend zu werden, wenn man bereits E-Mails verschicken und empfangen kann.

## Kontrolle

### Redsift

Fortlaufende Kontrolle des technischen Setups ist wichtig. Das aus meiner Sicht beste Tool hierfür ist https://redsift.com/tools/investigate.

**Screenshot von redsift**

Man schickt einfach eine E-Mail an die temporäre E-Mail von redsift und Sekunden später erhält man eine Auswertung über das technische Setup. Sollte hier etwas nicht grün sein, sollte man sich unmittelbar darum kümmern. Wichtig: man sollte alle ausgehenden Kanäle separat testen. Es mag sein, dass E-Mails aus einem Thunderbird komplett grün sind, während E-Mails aus deinem Ticketsystem Fehler aufweisen. Also alle ausgehenden Kanäle testen.

### Quelltext-Analyse mit KI

Eine weitere gute Möglichkeit, um die Qualität der E-Mails von einer KI bewerten zu lassen. Hierzu schickt man sich eine E-Mail an ein eigenes outlook.com oder gmail.com Postfach zu, holt sich den Quelltext der E-Mail und befragt eine KI, welches Optimierungspotenzial es noch gibt.

**Screenshot von quelltextanalyse mit perplexity**

### Reputation bei Microsoft und Google

Microsoft und Google bieten ...



###########



## Einrichtung ist wichtig
spf korrigiert
email.seatable.com einträge hinzugefügt
doppelten dkim (von mailcow) entfernt, weil darüber verschicke ich ja nie.
mta-sts auf aktiv gesetzt.


aus mailcow für seatable.com entfernt:
v=DKIM1;k=rsa;t=s;s=email;p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0nI3UWkHBTcXNbYGM5kLzQFRg2e45dJTBF/yeKRjHkIKNm3pc3AxrsSMLwuQ5vjgtMzr5tmm63926ROqK4YbTRNBFio/jeQ9xTrVNcBQxyqTb1QKWxFzHJhROTR9VxulcEPRIiq7xb054iiApboD5vLpgyk/Mlol7HJzXgkOwWvUoqFToxFxKa3gxKZFcJVMfqQT/XrU+j5Lf4fa14CbC2FiBVJm4yFvX4dDgX4IwhIVK4y9mfTlbEEqZ3V2zeGb7MY5bYFtUl2f8Ar7dgHAEU5EmhqLbv9t5Gd6PNbmECSGy0tCvGQVauSCmeT96e5aAFmHC4WxRIfRXSMyJk3OBQIDAQAB

# What is the goal:
- 99% delivery rate for all our emails
- early detection, if something goes wrong.

Our specific setup:
- alles geht über brevo.

## Kontrolle
https://redsift.com/tools/investigate ist das richtige tool, um sicherzustellen, dass alles stimmt.
=> wir hatten leider einen spf fehler!
=> der aktuelle "Hinweis" wird von mir noch optimiert.

Kontrolle darüber hinaus:
email an gmail und outlook.com schicken, source code von perplexity, etc analysieren lassen. => getan.

=> CMC-BIMI Zertifikat gekauft
Common Mark Certificate (CMC) enables BIMI for brands without a registered trademark, improving email deliverability
and brand recognition by displaying logos in inboxes.

# Überwachung
1) Google Postmaster Tools => christophdyllickbrenzinger@gmail.com =>  (keepassX)
  wie ist domain reputation und spam-rate
  => welche user soll ich hinzufügen?
  
2) Microsoft:
https://sendersupport.olc.protection.outlook.com/snds/addnetwork (cdb@seatable.io)
=> 19.11.2025

3) RUA, RUF reports
dmarc.seatable.com -> docker container...

4) Whitelist
https://www.dnswl.org/ (kostenlos) geht nicht bei brevo (dedicated email), die machen das schon
andere wie z.B. https://www.validity.com/everest/sender-certification/ sind alle kostenpflichtig.

5) Blacklisten überwachen.
https://mxtoolbox.com/blacklists.aspx (manuell)  mit ip: 172.246.35.50
https://blacklistchecker.com/check?input=172.246.35.50
  => cdb@seatable.io -> key_aNRamr9QPOBM7ZKgS7eC4mEXy
=> n8n workflow: curl https://api.blacklistchecker.com/check/172.246.35.50 -u key_aNRamr9QPOBM7ZKgS7eC4mEXy: | jq

# Auf aktuelle sperren überwachen
=> n8n workflow und notification

# zum entsperren, wenn man eventl solche messages bekommt

Reason: 550 5.7.1 Unfortunately, messages from [172.246.35.50] weren't sent. Please contact your Internet service provider since part of their network is on our block list (S3150). You can also refer your provider to http://mail.live.com/mail/troubleshooting.aspx#errors. [Name=Protocol Filter Agent][AGT=PFA][MxId=11BCB2B2FC29281C] [SA2PEPF00003AE4.namprd02.prod.outlook.com 2026-01-24T07:00:10.851Z 08DE595980A54C54]

https://olcsupport.office.com/
https://sender.office.com/

######

ssl2buy: cdb@seatable.com + Ionas12345#

##########

ocrmypdf.exceptions.PriorOcrFoundError: page already has text! - aborting (use --force-ocr to force OCR;  see also help for the arguments --skip-text and --redo-ocr


### noch offen:
- BIMI Zertifikat einbinden
- verknüpfte domain bei brevo von email.seatable.io auf email.seatable.com ändern
- Absender presse@seatable.io und noreply@seatable.io aus brevo entfernen
- Prüfen, ob ich automatisiert jeden Morgen eine E-Mail an eine @gmail und @outlook.com schicken kann - quasi frühwarnsystem.

## Next steps:
- CDB: Regelmäßige Kontrolle, ob wirklich alles
- PST/FHE:
  - Kampagnen nur noch per @seatable.com
  - Testen von hotmail.com / outlook.com und dann Kampagnen für diese Kunden wiederholen
  - Auschlüsselung der Zustellbarkeit nach Domain überwachen
  - Google Postmaster Tools, Microsoft Sender Network und dmarc.seatable.com überwachen


marketing@seatable.com
presse@seatable.com

mails an sich selbst schicken, dann header auslesen.
RSPAMD



--------
--------


Erst SPF- und DKIM-Eintrage
- https://dmarcly.com/tools/spf-record-checker
- https://dmarcly.com/tools/dkim-record-checker

################

DMARC
- https://dmarcly.com/tools/dmarc-checker

################

SPF
v=spf1 -all
 => läuft

########

TLS-RPT

MTA-STS
https://dmarcly.com/tools/mta-tls-checker

########################

BIMI
https://dmarcly.com/tools/bimi-record-checker
https://dmarcadvisor.com/de/bimi-check/?

Konkreter Eintrag
default._bimi.seatable.com
v=BIMI1; l=https://seatable.com/bimi.svg; a=;


##########

super tool:
https://redsift.com/tools/investigate


https://redsift.com/tools/investigate?utm_source=google-c&utm_campaign=OnDMARC_EMEA&utm_medium=ad&utm_content=Investigate_tool&utm_term=spf%20checker&hstk_creative=667036972942&hstk_campaign=17554707731&hstk_network=googleAds&gad_source=1&gad_campaignid=17554707731&gbraid=0AAAAADPOkYYBMxbXSZaYMQgGVuY3jZFIb&gclid=EAIaIQobChMImbD23vrJkQMVSZODBx2_xwCBEAAYASAAEgKRT_D_BwE
https://dmarcly.com/tools/mta-tls-checker
https://www.gov.uk/government/publications/email-security-standards/using-tls-reporting-tls-rpt-in-your-organisation


----------------
----------------

tar --xz -cvf bewirtungsbelege_eigenbelege.tar.xz ./Bewirtungsbelege\ \&\ Eigenbelege/

cd /shared
seatable.sh python-env /opt/seatable/seatable-server-latest/dtable-web/manage.py import_dtable_folder --workspace-id="51581" --path="/shared/AKTUELL_VERWALTUNG_TRANSAKTIONEN_BELEGE"

+--------+-----------------------------------------+--------------+
| id     | name                                    | workspace_id |
+--------+-----------------------------------------+--------------+
| 233729 | AKTUELL_VERWALTUNG_TRANSAKTIONEN_BELEGE |        51581 |



discourse + posthog.
https://share.google/aimode/5aoM7Id1ZU5ZyVJLV


-------------------------


Whitelisten: !!!

=> bringt halt ncihts. die ip von brevo ist bereits bei denen. die von mailcow, nutzen wir ja nicht für den versand!

https://help.brevo.com/hc/de/articles/8847188389650-FAQ-Warum-ist-meine-IP-Adresse-oder-Dom%C3%A4ne-geblocklistet?input_string=spam

172.246.35.50   email.seatable.io
188.34.205.91   mail.seatable.com  -> DNSWL Id 31758

olcsupport.office.com
=> 7096225675




  
