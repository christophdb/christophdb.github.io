---
title:  "Reach every mailbox"
date:   2025-02-01
description: "..."
url: "reach-every-mailbox"
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

## Kontrolle des technischen Setups

### Redsift

Fortlaufende Kontrolle des technischen Setups ist wichtig. Das aus meiner Sicht beste Tool hierfür ist https://redsift.com/tools/investigate.

**Screenshot von redsift**

Man schickt einfach eine E-Mail an die temporäre E-Mail von redsift und Sekunden später erhält man eine Auswertung über das technische Setup. Sollte hier etwas nicht grün sein, sollte man sich unmittelbar darum kümmern. Wichtig: man sollte alle ausgehenden Kanäle separat testen. Es mag sein, dass E-Mails aus einem Thunderbird komplett grün sind, während E-Mails aus deinem Ticketsystem Fehler aufweisen. Also alle ausgehenden Kanäle testen.

### Quelltext-Analyse mit KI

Eine weitere gute Möglichkeit, um die Qualität der E-Mails von einer KI bewerten zu lassen. Hierzu schickt man sich eine E-Mail an ein eigenes outlook.com oder gmail.com Postfach zu, holt sich den Quelltext der E-Mail und befragt eine KI, welches Optimierungspotenzial es noch gibt.

**Screenshot von quelltextanalyse mit perplexity**

### Reputation bei Microsoft und Google

Schätzen gehen davon aus, dass Microsoft und Google zusammen über 60% aller Business E-Mailkonten weltweit ausmachen. Somit ist es extrem wichtig, sich auf diese beiden Anbieter zu konzentrieren. Beide bieten jeweils einen eigenen Dienst an, bei dem man seine reputation überwachen kann. Eine Anmeldung und regelmäßiger Check bei diesen beiden Diensten ist somit sehr zu empfehlen:

- [Google Postmaster Tools](https://gmail.com/postmaster/)
- [Smart Network Data Service von Microsoft](https://sendersupport.olc.protection.outlook.com/snds/)

### DMARC Report Analyzer

Eine weitere Möglichkeit frühzeitig auf Probleme mit DMARC, DKIM und SPF hingewiesen zu werden, sind die RUA- (Reporting Under Aggregate) und RUF- (Reporting Under Forensic) Berichte. Man gibt in seinem DMARC DNS Eintrag eine oder mehrere E-Mailadressen an und die Empfänger schicken dort Ihre Berichte hin. 

```
v=DMARC1; p=quarantine; rua=mailto:dmarc@seatable.com; ruf=mailto:dmarc@seatable.com
```

Zur Analyse dieser Reports kann ich den [DMARC Report Viewer von cry-inc](https://github.com/cry-inc/dmarc-report-viewer) empfehlen. Dieser holt sich eigenständig die Berichte aus einem Postfach ab und stellt diese grafisch übersichtlich dar. Sollte es zu einem Fehler kommen, kann man sich auch den Quelltext des entsprechenden Berichts anzeigen lassen, um diesen weiter zu analyisieren.

Mit diesen Tools sollte man sicherstellen können, dass das technische Setup bestehend aus DNS-Einträgen sauber eingerichtet ist.

## Fortlaufende Überwachung

### Blacklists

Jeder hat wahrscheinlich schonmal davon gehört. Die eigene IP-Adresse steht auf einer Blacklist, und deshalb werden die E-Mails vom empfangenden Mailserver nicht angenommen oder verworfen.
Typischerweise bietet jede Blacklist die Möglichkeit sich wieder von dieser entfernen zu lassen, aber man muss eben auch mitkriegen, dass man auf einer solchen steht.

Die einfachste Möglichkeit ist es die eigene IP-Adresse auf https://mxtoolbox.com/blacklists.aspx einzugeben. Dieser manuelle Check prüft unmittelbar gegen mehr als 50 Blacklisten und liefert eine übersichtliche Tabelle.

**Screenshot von mxtoolbox**

Wer es lieber automatisch möchte, dem kann man den Dienst https://blacklistchecker.com/ empfehlen. Dieser bietet auch einen kostenlosen Online-Check, aber auch eine API, die bis zu 50 kostenlose Checks pro Monat erlaubt.

Der folgenden n8n Workflow prüft z.B. jeden Morgen unsere IP daraufhin, ob Sie auf einer Blacklist steht. 

**Screenshot von n8n workflow**

### Whitelists

Weit weniger bekannt ist, dass es auch Whitelists gibt. Eine IP-Adresse, die auf diesen Listen steht, sollte vertrauenswürdig sein und somit von den Empfängern eher zugelassen werden.
Es gibt diverse kostenpflichtige Anbieter wie z.B. https://www.validity.com/everest/sender-certification/, die horrende Summen aufrufen und lediglich versprechen, dass E-Mails dann besser zugestellt werden. Wir haben bisher auf diese kostenpflichtigen Anbieter verzichtet, weil kein messbarer Vorteil ersichtlich ist und dafür die Preise einfach zu hoch sind.

Mit dnswl.org gibt es jedoch auch einen kostenlosen Dienst. Wenn man bei Brevo eine dedizierte E-Mail hat, ist diese IP-Adresse bereits auf Brevo registriert. Somit muss man hier nicths tun. Wenn man einen eigenen Mailserver betreibt, sollte man sich die Mühe machen, und die eigene IP-Adresse hier hinterlegen. Wieviel es bringt, ist unklar. Aber schaden kann es auf jeden Fall nicht.

### Testversand

Brevo liefert bietet für jede versendete E-Mail ein Transaktionslog. Somit liegt es nahe, dass man regelmäßig quasi eine Test-E-Mail verschickt und dann prüft, ob diese auch zugestellt wrden konnte. Wir haben das mit einem weiteren n8n Workflow abgebildet, bei dem wir jeden Tag eine E-Mail an eine @outlook.com Adresse verschicken und dann eine Minute später die erfolgreiche Zustellung überprüfen. Den selbst wenn technisch alles sauber ist und man auch auf keiner Blacklist steht, kann es sein, dass die eigenen E-Mails nicht zugestellt werden.

### Softbounces und Hardbounces überwachen

Brevo bietet die Möglichkeit sich per Webhook über Softbounces und Hardbounces informieren zu lassen. Diesen Webhook empfangen wir per n8n und informieren den Sender darüber, dass eine E-Mail nicht zugestellt werden konnte. Dies ist zu einem unverzichtbaren Werkzeug für uns geworden, den was gibt es schlimmeres als dass man eine Rechnung oder ein Angebot an einen Kunden schickt, und diese E-Mail einfach nicht im Postfach des Kunden ankommt. 

**Screenshot von Brevo zu Soft- und Hardbounce**

### Finetuning: Auswerten der Header von RSPAMD

...Auslesen von E-Mail Headern von z.B. RSPAMD. Dort kriegt man zusätzlich Informationen, warum man ggf. bei einem Kunden im Spamordner gelandet ist. Dies kann von einer fehlerhaften Kodierung eines Anhangs über zu wenig Text im vergleich zu Grafiken ganz vieles sein und ist eine sehr indeividulle Konfiguraiton des Mailserver-Administors. Das ist dann das aboslute finetuning, aber auch hier hilft die Analyise der E-Mail Header mit Hilfe von KI um Hinweise auf mögliche Fehler zu finden.

## Aktives Entsperren

Selbst bei all dem technischen Aufwand, perfekten E-Mails und einer geprüften Empfängerliste kann es passieren, dass man einfach nicht mehr durchkommt. In unserem Fall war es wie gesagt die Blocklist von Microsoft, die uns das Leben schwer gemacht hat. So erhielten wir folgenden Fehlermeldungen zurück:

```
Reason: 550 5.7.1 Unfortunately, messages from [172.246.xx.xx] weren't sent. Please contact your Internet service provider since part of their network is on our block list (S3150). You can also refer your provider to http://mail.live.com/mail/troubleshooting.aspx#errors. [Name=Protocol Filter Agent][AGT=PFA][MxId=11BCB2B2FC28272C] [SA3PEPG00002BF1.namprd02.prod.outlook.com 2026-01-24T07:00:10.851Z 07DD451350B34C54]
```

Zum Entsperren bietet Microsoft zwei verschiedenen Formulare an: 
- https://olcsupport.office.com/
- https://sender.office.com/

Die Formulare auszufüllen, ist nicht weiter schwierig und normalerweise erhält man in jedem Fall nach 1-2 Tagen eine automatisch Antwort, dass es keinen Grund gibt, warum die E-Mails nicht zugestellt werden können. Unserer Erfahrung nach ist es notwendig, auf diese E-Mails zu antworten und um erneute Prüfung zu bitten. Irgendwann wird dann diese E-Mail an einen Mitarbeiter weitergeleitet, der sich dann wirklich um das Thema kümmert. 

Dann kann man damit rechnen, dass die IP-Adresse wieder von der Blocklist entfernt wird, wodurch man wieder in den Postfächern von Microsoft E-Mailkonten landet. Der Prozess ist zwar absolut intransparent und mühsam, aber leider nicht zu vermeiden, wenn man erstmal auf dieser Blocklist steht.

## Optional: VMC oder CMC-BIMI Zertifikat

Eine weitere Möglichkeit, um die eigene IP bzw. Marke mit mehr Trust auszustatten, ist ein digitales Zertifikat im Rahmen des BIMI-Standards (Brand Indicator for Message Identification). Hört sich erstmal kompliziert an, ist am Ende aber nichts anderes als ein digitales Zertifikat, welches ausweist, dass man ein Logo bzw. eine Marke bereits mindestens 12 Monate nutzt und man sich entsprechend ausweisen kann.

Aktuell gibt es zwei solcher Zertifikate:
- CMC (Common Mark Certificate)
- VMC (Verified Mark Certificate)

CMCs sind günstiger und schneller ausgestellt, da Sie nur den Nachweis über die Logo Nutzung erfordern. Bei VMC muss man zwingend eine Markenanmeldung (z.B. beim europäischen Markenregister) nachweisen. Neben dem zusätzlichen Vertrauen, dass diese Zertifikate mit sich bringen, haben Sie den vorteil, dass in manchen Mailclients, das eigene Logo angezeigt wird.

Wir haben uns dafür entschieden ein CMC bei zu beantragen und die Kosten von xxx € pro Jahr zu investieren. Noch läuft der Beantragungsprozess, somit kann ich aktuell noch nicht über eventuelle Vorteile berichten. Wenn Ihr das lest, könnt ihr mich gerne kontaktieren und ich teile meine bisherigen Erfahrungen.

**Screenshot**

## 100% Zustellquote ist das Ziel und erfordert konsequente Arbeit

hier ncoh eine zusammenfassung.


