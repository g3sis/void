# IT-Sicherheit Winter 23

----

# Chapter 1

## 1.1 Begriffe

  **Security and Safety**

- *Security*: Bewahren vor Beeintr. und Missbrauch von Aussen
- Was schuetzen, welche massnahmen
- z.B.: Netztrennung, speicher sparsamkeit, encryption, 2F auth
- Angriffe: Daten Manipulation, Informationsmissbrauc, Funktionsstoerung
- z.B: Passwort hacken: Brute Force, Dictionairy, Social Eng.
- Schutz dagegen: Fehlereing. Zaehlen, pw regeln,
- *Safety*: Funktions-, Betriebssicherheit
- z.B.: redundanz
- Schwachstelle (Vulnerability) - ermöglicht es, dass die
    Sicherheitskontrollen des Systems umgangen oder
    getäuscht werden können
- Bedrohung (Threat) - in Umstand oder Ereignis mit dem
    Potenzial, ein System durch unbefugten Zugriff,
    Zerstörung, Offenlegung, etc. zu beeinträchtigen.
- Angriffsvektor - Ein konkreter Angriffsweg, der eine
    oder mehrere Schwachstellen ausnutzt, um die Sicherheit
    eines Systems zu gefährden

-----

## 1.2 Angrifsklassen

  1. *Ungenuegende Eingabevalidierung*
      - Buffer-Overflow
      - Code-Injection (SQL, etc.)
      - XSS (kap1/slide 23) - passwords und access token abgreifen
  2. *Identity Theft*
      - ARP-Spoofing, IP-Address-Spoofing
      - Angriffsvektor: Man in the middle
  3. *Man in the Middle*
      - Arp Cache-Poisoning (kap1/25)
  4. *Angriffe auf Verfuegbarkeit*
      - (D)DOS
      - Service Ausfall
  5. *Faktor Mensch*
      - Social Engineering
  6. *Web-App Security*
      - OWASP Top 10

---

## 1.3 Klassen von Schadcode (Malware)

  1. Virus
      - nicht selbststaendiges Programm, dass sich selbst in nicht infizierte Dateien kopiert
      - benoetigt Wirtsoprogramm um ausgefuehrt zu werden
      - Stuxnet, Emotet
  2. Trojaner
      - neben spezifischer nuetzlicher Funktionality versteckte Funktionality
      - Keylogger
  3. Ransomware
      - Encrypting data on vulnerable device
      - WannaCry

---

## 1.4 Schutzziele

  Base-Goals: **CIA** - *C*onfidentiality *I*ntegrity *A*vailability

  1. C: Informationsvertraulichkeit - schutz vor unautorisierter Informationsgewinnung
      - Encryption der Informationen
      - Kontrolle von Zugriffen
  2. I: Datenintegritaet - schutz vor unbemerkter und unautorisierter Modifikation
      - verhindern nicht immer moeglich, ziel ist eher mit manipulierten daten zu arbeiten
      - Zugriffskontrolle
      - Redundanz (z.B.: RAID) und Vergleich
  3. A: Verfuegbarkeit - schutz vor unbefugter Beeintraechtigung der Funktionalitaet
      - redundanz (RAID)

  But wait, theres more!!!!

  4. Authenticity
      - nachweis der echtheit und glaubwuerdigkeit der identity einer entity
      - z.B.: Passwort
  5. Accountability
      - verbindlichkeit von handlungen
  6. Privacy
      - kontrolle ueber personenbezogene daten

  In der Regel werden in Systemen Kombis aus mehreren Zielen gefordert (Bsp kap1/35)

---

## 1.5 Security-Policy

- Regelwerk mit Schutzzielen
- Legt Verantwortungen fest
- Bsp.: SOP (kap1/37)

---

# Chapter 2 Kryptografische Grundlagen

  1. Kryptografie: Methoden zu Ver- und Entschluesselung
  2. Kryptoanalyse: Wissenschaft von Methoden zu Verschuesselung

## 2.1 Kryptografisches System (M, C, E, D, K)

- Menge der *Klartexte m*, ueber Alphabet **M**, m in M*
- Menge der *Kryptotexte c* ueber Alphabet C, c in C*
- **K** Menge der Keys
- **E** = {E_e | E_e : M*-> C*} Familie von Verschluesselungsverfahren
- **D** = {D_d | D_d : C*-> M*} Familie von Entschluesselungsverfahren

---

## 2.2 Verfahren

- Symetrisch
  - Verfahren E, D idR einfach und schnell zu berechnen
  - e, d sind gleich (*symetrisch*) und geheim (*Secret Key*)
  - Bsp.: Caesar-Chiffre
- Asymetrisch (weil e und d ungleich), Public-Key Kryptografie
  - Verfahren E, D basieren auf Zahlentheorie, Gruppentheorie
  - Ein Schluesselpaar pro Entity
    - *public* Key e
    - *private* Key d
  - Encryption mit e
  - Decryption mit d
  - Private Key kann als signatur verwendet werden, ist dann kein Geheimnis mehr tho
  - Anforderungen:
    - for (e,d): D_d(E_e(m)) = m, forall m. d ist private Key und muss geheim bleiben
    - d kann aus e nicht effizient berechnet werden
  - Theoretische Basis:
    - Einwegfunktion f: X -> Y
              1. forall x in X. f(x) effizient berechenbar
              2. forall y in Y. f^-1(y) = x nicht effizient berechenbar
    - Trapdoor-Einweg
    - Beispiele:
              1. Faktorisierung
              2. Diskreter Logarithmus
  - Beispiel: **RSA-Verfahren** (siehe slides oder wikipedia)

---

## 2.3 Anforderungen an kryptografische Verfahren

**Kerckhoffs-Prinzip**

- strength von verfahren sollte nur von der guete des geheimen keys abhaengen und nicht von geheimhaltung! Keine security by obscurity
- -> sehr grosser schluesselraum um brute-force angriffe unpraktikabel zu machen

**Anforderungen an Keylength**

- symetrisch: >= 128 Bit
- asymetrisch: >= 3000 Bit ab 2023

---

## 2.4 Block und Stromchiffren

### 2.4.1 Blockchiffre (symetrische Verfahren)

**Funktionsprinzip**

- Klartext m wird in Blokcs *m*_*i* fester Laenge (z.B.: 128 bit) zerlegt
- Blockweise encryption mit gleichem Key *k*
- *Padding:* Auffuellen des Klartextes, so dass dessen length ein Vielfaches der Blocksize

**Designprinzipien**

- Diffusion: jedes klartextbit beeinflusst jedes Ciphertextbit (Technik: Bitweise Permutation)
- Konfusion: Zusammenhang zwischen Key und Ciphertext verschleiern
- Beispiel AES (Siehe Slides)

---

### 2.4.2 Stromchiffre  

- Ziel: schnelle Verschluesselung eines Klartext-Stroms: muss schnell sein - xor
- Problem: xor ist keine starke Chiffre
- Solution: jeder Klartextstrom bekommt eine pseudozufaellige Schluesselfolge KS aus Bits

#### 2.4.2.1 Funktionsprinzip

- Encryption: m xor KS (bitweise xor bzw add mod 2)
- Kern ist eine gute Key Sequence KS
- Sol. in praxis:
  - kryptografischer Pseudozufallszahlengenerator (CSPRNG) mit Seed-Wert initialisiert
  - Deterministischer Prozess bei gleichem Seed
- Konsequenz:
  - Seed-Wert k ist unabhaengig von Nachrichtenlaenge und kann wie ein sym. Key behandelt werden
  - -> KS kann mit k rekonstruiert werden
- 2 Ansaetze
  - Dedizierte Chiffre: ChaCha20
  - Blockchiffre basiert: CSPRNG durch Blockchiffre umgesetzt
- Geforderte Eigenschaf
  - Untersch. Klartexte m_1, m_2 erfordern untersch. Schluesselfolgen KS_1, KS_2
- Symetrischer Schluessel k muss sich bei jeder Nachricht aendern

### 2.4.3 Betriebsmodi von Blockchiffren

  1. ECB: Electronic Code Book Modus
      - Vorteil:
          - Parallelisierung der Verschl.
          - Keine Fehlerausbreitung
      - Nachteil:
          - Gleiche Klartext-Bloecke ergeben gleiche Chiffre-Bloecke: Muster bleiben erhalten
      - Konsequenz:
          - Sichere Blockchiffre kann im ECB-Modus angreifbar werden
  2. CBC - Cipher Block Chaining
      - Klartextblock xor mit vorherigem Chiffretextblock
      - Startwert= Initvektor IV
      - Siehe Slides fuer genauer
  3. CTR - Counter Mode
      - Init of Counter ctr mit Zufallszahl Nonce
      - Zaehlerstand pro Block m_i: ctr(i) = ctr(i-1)+1
      - Encrypt. des i-ten Blockes: c_i = m_i xor E_k(Nonce||ctr(i))
      - Decrypt. des i-ten Blockes: m_i = c_i xor E_k(Nonce||ctr(i))
      - Bsp.: Siehe Slides
  4. GCM - Galois/Counter Mode
      - Encrypt. Block m_i, 128 Bit lang, durch Blockchiffre in CTR
      - Authenticate Data durch Multiplikation im Galoiskoerper GF(2^128)
      - Input: Klartext m, Key k, IV, ggf. assoziierte Daten, z.B.: Header (werden auch authentifiziert)
      - Implementiert AEAD-Eigenschaften (Authenticated Encryption with Associated Data)

## Elliptische-Kurven-Kryptographie (ECC) (Asym)

  **Problem:**

- Public-Key Verfahren erfordern hohen rechen und speicher Aufwand wegen grosser public und private Keys
  **Gesucht:**
- zyklische Gruppen, in denen das Problem des Diskreten Log. DLP schwer zu loesen ist und die mit kuerzeren Keys arbeiten koennen
  **Solution:**
- Elliptische Kurve
  **Def.:**
- Siehe Slides kb aufzuschreiben

---

# Chapter 3 Kryptografische Hashfunktion und MAC

## 3.1 Kryptografische Hashfunktion

**Idee:**

- Erstellen eines digitalen Fingerprints
- Vorgehen:
  - gegeben eine Hashfunktion H, n Ganzzahlwert
  - Hashfunktion H, H: M^* -> M^n, z.B. n =128, h der Laenge n Bit
  - h = H(m), h nennt man auch Message Digest, feste Laenge

**Konstruktion von H mit Kompressionsfunktion f**

- *Merkle-Damgard* wird oft genutzt (MD5, SHA1, SHA2)
- Siehe Slides

**Schutzziel: Integrity**

- Anforderung
    1. Hashwert h = H(m) charakterisiert Nachricht m eindeutig
    2. Eine Modifikation von m ergibt Nachsticht m' mit H(m') = h'
    3. Damit eine Mod. erkannt werden kann, muss gelten: wenn m != m' gilt auch h != h'
- Problem: H ist nicht injektiv -> Kollisionen (m != n && H(m) = H(n)) moeglich
- Konsequenz: Kollisionen dueren fuer H nicht effizient erzeugbar sein

---

## 3.2 Anforderungen an eine kryptografische Hashfunktion H

  1. forall m in M^*.: H(m)=h ist einfach zu berechnen
  2. Einwegeigenschaft (preimage resistance): Gegeben sei h = H(m) dann ist m = H^-1(h) nicht effizient berechenbar
  3. Schwache Kollisionsresistenz (second-preimage resistance)
  3. Starke Kollisionsresistenz (collision resistance)

- Frage: Wie gross sollte der Hashwert sein, damit Funktion H kollisionsresistent ist?
- Antwort: Siehe Slides!

---

## 3.3 Drei Klassen von Hashfunktionen

  1. Basierend auf Block-Chiffren:
     - Bsp.: H = AES-CBC
  2. Dedizierte Hashfunktionen
     - SHA-1 - **unsicher!**
     - SHA-2-Familie: SHA-256 Bit
        - Basierend auf Merkle-Damgard Konstruktion - length extension
        - SHA-512/256 resistent gegen length extension
     - SHA-3: aktueller Standard
         - Basiert auf Sponge-Prinzip
            1. aufsaugen (slides)
            2. ausgeben (slides)
         - Length zwischen 224-512 Bit
         - Resilient gegen length extension attacks
  3. Passworthashfunktionen
     - Background - Passwords sollen gehasht abgespeichert werden
     - Spezielle Anforderungen an H, um Angriffe zu erschweren:
        - Abgleich soll "langsam" sein: Abwehr von Brute Force Angriffen
        - Ableich soll viel Speicher und CPU-Zeit benoetigen
     - Solution: parametrisierbare Hashfunktoinen die man bei Bedarf "abbremsen" kann

---

## 3.4 Message-Authentication-Code (MAC)

- Ziel: Authenticity des Datenursprungs
  - Idee:
    - Einbringen eines gemeinsamen Geheimnisses in die Hash-Berechnung
  - MAC:
    - Hashfunktion mit Key: H: EK cross M^* -> M^n
    - Geheimer (Pre-Shared) Key k_AB zwischen Partnern A,B
    - MAC-Berechnung: SLIDES!
    - Recipient checkt Authenticity und Integrity von m' mit k_AB
  - Anwendungsbeispiel auf Slides
  - Sicherheit:
    - Problem bei Merkle-Damgard: length extension-Angriffe (SLIDES)
  - HMAC-Verfahren RFC 2104
    - Schau Slides an

---

## 3.5 AEAD (Authenticated Encryption with Associated Data)

  - Bislang: Einzelne Krypto-Primitive für CIA Goals
  - Problem: oft falshce Verwendun -> Vulnerabilities 
  - AE und AEAD sind weitere Betriebsmodi einer Blockchiffre

---

## 3.6 Elektronische Signatur
  - Goal: Nachweis der Urheberschaft einer Nachricht

### 3.6.1 Funktionsprinzip
  - Basis: Public Key Verfahren
  - Achtung: Keys sind keine Encryption
    1. Signaturkey k_sig
    2. Public Verificationkey k_veri
  - Vorgehen: Erstellen einer elektronischen Signatur
  - Ablauf: 
    1. Hashen
    2. Signieren
  - Check auf Korrektheit
    1. B besitzt den public Key e von A, Rekonstruktion eines Hashwertes h' durch Sig.-Val.
    2. B berechnet den Hashwert der Nachricht
    3. Validieren 
  - Einsatz bei z.B.: signierten e-Mails, Verträgen, Finanzdaten

---

# Chapter 4 Schlüsselmanagement

## 4.1 Generierung symmetrischer Keys
  - Kerkhoffs-Prinzip: Strength des Kryptoverfahrens sollte nur von der Güte des Schlüssels abhängen -> Starke symmetrische Keys need high Entropy
  - Entropy und Kryptografie:
    - Attacker soll so wenig über die Quelle, die die Bits generiert wissen wie geht
    - Hohe Entropie im Key

### Generatoren:
  1. TRNG - True Random Number Generator
    - Entropiequelle based auf physikalischen Phänomenen (Atomspheric Rauschen, Mausbewegungen, thermisches Rauschen, etc.)
  2. PRNG - Pseudo Random Number Generator
    - Deterministischer Algorithmus, der nach außen hin random wirkt
    - basiert auf Seed, dessen Kenntnis die Berechnung aller Ausgaben von PRNG-Funktion bewirkt
    - Seed muss also Vertraulich sein

  - CSPRNG - Cryptographicly Secure Pseudo Random Number Generator
    1. PRNG mustn't be predictable, even if attacker knows parts of the generated Random Number
    2. abgefangene Zahlen geben keinen Hinweis auf vorhergehende Zufallszahlen
    3. Zufallsfolgen sollten statistisch gleichviele Nullen und Einsen haben und nicht komprimierbar sein
  - Beispiel: Hardwar - Nichtlinear rückgekoppeltes Schieberegister

---

## 4.2 Etablierung gemeinsamer Keys
1. Key Distribution
2. Key Agreement

### 4.2.1 Key Distribution mit zentraler Verteilung 
  - Problem: Key Distribution vorab, jeder mit jedem, skaliert nicht
  - Solution: Zentraler Verteilungsserver -> oft KDC-Server wird als **T**rusted **T**hird **P**arty bezeichnet
  - Funktion in SLIDES auch mit Protokoll

### 4.2.2 Keyexchange mit hybridem Ansatz, dezentral
  - KEM: Key Encapsulation Mechanism
  - Symmetrischer Key k_AB wird asymmetrisch Encrypted
  - Siehe SLIDES
  - Perfect Forward Secrecy
  **PFS-Forderung:**

### 4.2.3 Diffie-Hellman-Verfahren (DH)
  - Verfahren zur dezentralen Key Agreements
  - Public-Key Verfahren, das nicht zum encrypten benutzt werden kann
  - Funktionsweise auf SLIDES
  - Phasen:
    - Ziel:
      - A und B brauchen gemeinsamen sym. Key als basis fuer vertrauliche kommunikation
    - Vorgehen
      1. Austausch von public Info zwischen A und B
      2. lokale Berechnung eines shared DH-Secrets
      3. Mit festgelegter Funktion, erzeugen A und B lokal auf der Basis des DH-k_AB den gemeinsamen Key
- Ablauf:
  - Phase 1 und 2
    1. grosse Primzahl p aussuchen (allen Teilnehmern bekannt)
    2. nicht geheimen Wert g in |Z^*_p aussuchen, Generator-Element
 - Phase 3:
   - A und B haben lokal den Shared DH-Key berechnet
   - Key kann als Parameter for PRNG genutzt werden um sym. Keys zu generieren
   - Ableiten von Keys auf Basis von DH-k_AB
     - Nutzen einer Key-Derivation-Funktion KDF: meist eine Keyed-Hashfunktion
     - Parameter der KDF: DH-k_AB und weitere Parameter u.a. Keylength n
     - Jeder Partner berechnet unabhaengig vom anderen Partner 
 - Problem: MitM-Attack
 - Solution: Signierter Austausch der Public Keys

### 4.2.4 PFS-Umsetzunf mit dem DH-Verfahren    

---

# Chapter 5 Digitale Identitaet, Authentisierung

## 5.1 Einordnung/Begriffsklaerung
  - Schutzziel - Autenticity:
    - Echtheit und Glaubwuerdigkeit einer Identity
  - Authentisierung/Authentifikation
    - Pruefung der Authenticity, BAsis: eundeutige Identity
  - Identity:
    - Name, Identifier, charakterisierende Attribute
  - Autorisierung 
    - Vergabe von Zugriffsberechtigungen
  - Personenbeziehbare Daten nach DSGVO
    - Personenbezogene Daten sind gemäß Art. 4 Nr. 1 DSGVO „alle Informationen, die sich auf eine identifizierte oder identifizierbare natürliche Person beziehen.“
  - Pseudonymisierung siehe SLIDES
  - Anonymisierung

## 5.2 Drei Klassen von Faktoren zur Authentisierung
1. Wissen: pw,PIN, Key
2. Besitz: Smartcard, Token, Sim Karte
3. Biometrie: Fingerprint, Gesicht, Tippverhalten
#### **Multi-Faktor Authentisierung:**
  - Kombination verschiedener Authentisierungsfaktoren
  - 2-Faktor-Authentisierung
    1. Kennung und Passwort
    2. Eingabe einer dynamisch generierten Einmal-TAN

### 5.2.1 Authentifikation durch Wissen: Passworte 
  - Problem: Passwortdiebstahl
  - Angriffe: Dictionary-Attack, Phishing, Social Engineering
  - Abwehr: gute Passwords und Mehrfaktor-Authentisierung
  - Was ist ein gutes PW? -> Sliiiiides

### 5.2.2 Authentifikation durch Besitz
  - Hadware Token als Identity nachweis
  - Hadware-basierte OTPs sind *Token* - besitzt eindeutige Nummer die Server kennt
  - Bsp.: RSA SecureID-Token
    - Basis: Auf Server liegt ein Benutzer-Account mit:
      - Token-Nummer und 128-Bit Seed
      - Seed wird auch im RSA-Token gespeichert
      - TOkenlebenszeit 1-5 Jahre, automatisches Abschalten nach Ablauf
    - Erzeugen von OTPs: auf Server und in Token
      - alle 60 sec, OTP = AES(TokenId|s|Zeit), 6-8 stellige Zahl
    - Login mit RSA-Token:
      - OTP wird auf Token-Display angezeigt
      - Nutzer gibt Code ein
    - Validierung eines OTP durch Server:
      - next 3-5 OTPs zugelassen. 8 sec abweichung wird toleriert

### 5.2.3 Authentifikation durch Biometrie
  - Biometrisches Merkmal: Verhaltenstypische oder physiologische Eigenschaft eines Menschen, die diesen eindeutig charakterisieren
  - Klassen:
    - statisch - physiologische Merkmale: nur geringe Possibilities zur Auswahl oder Aenderung von Referenzdaten
    - dynamisch - Verhaltensmerkmale: Merkmal ist nur bei bestimmten Actions vorhanden (Stimme, Tippverhalten)
  - Anforderungen an biom. Merkmale:
    - *Universalitaet:* Jede Person besitzt das Merkmal
    - *Eindeutigkeit:* Merkmal ist fuer jede Person verschieden
    - *Bestaendigkeit:* Merkmal ist unveraenderlich
    - *Quantitive Erfassbarkeit* mittles Sensoren 
    - *Performance:* Genauigkeit und Geschwindigkeit
    - *Acceptance* des Merkmals beim User
    - *Faelschungssicherheit*
  - Vorgehen:
    - Vorbereitung: einmalig
      1. Messdatenerfassung durch biometrischen Sensor und Digitalisierung
      2. Enrollment: Registrieerung eines Users - AUfnahme, Auswahl und Speicherung der Referenzdaten
   - Bei jeder Authentisierung
     3. Erfassung der aktuellen Verifikationsdaten
     4. Verifikationsdaten digitalisieren
     5. Vergleich mit gespeichertem Referenzwert, Toleranzschwellen sind notwendig
  - Probleme
    - Abweichungen zwischen Referenz- und Verifikationsdaten
    - Zwei Fehlertypen:
      - Berechtigter Benutzer wird abgewiesen, -> Akzeptanzproblem (*false negatve*)
      - Unberechtigter wird authentifiziert, Kontrollen zu locker -> Sicherheitsproblem (*false positive*)
    - Leistungsmasse zur Bewertung der Guete eines Systems
      - *False-Acceptance-Rate (FAR)*
      - *False-Rejection-Rate (FRR)*
      - *Equal Error Rate(ERR)*
  - Fazit:
    - Quality der Sensoren:
      - hohe Anforderungen in Hochsicherheitsbereichen, hoheitlichen Identifikationsdokumenten (PA, Pass)
      - Bei Commodity Produkten oft leicht zu ueberlistende, einfache Sensoren
    - Probleme:
      - Bedrohung der informationellen Selbstbestimmung
      - Gefahren durch gewaltsame ANgriffe gegen Personen
      - Probleme der oeffentlichen Daten und rechtliche Aspekte
      - Ethische Problem: gefahr der Diskriminierung
      - Zunehmend: Deepfakes

## 5.3 Challenge-Response Verfahren
  - Schema zur Authentizitaespruefung: einseitig/wechselseitig
  - Allgemeiner Ablauf for single sided Authentisierung:
    - A (Person, Device,...) gibt Identity an
    - B (Server, ...) sendet eine Challenge an A
    - A erstellt Response fuer B
    - B prueft Response
  - Symmetrisches CR-Verfahren - SLIDES
  - Asymmetrisches CR-Verfahren - SLIDES
  
## 5.4 Fazit
  - Versch. Fatoren zur Authentosoerung
    - Wissen
    - Besitz
    - Biometrie
  - Mehr-Faktor-Authentisierung ist heutzutage der State-of-the-Art 
  - Allgemeines Schema zur ein und wechselseitigen Authentisierung: Challenge/Response

# Kapitel 6: Public Key Infrastructure (PKI), Single-Sign-on

Fragestellungen:  
  1. Authentizity von Public Keys: Zertifikate und PKI
  2. Authentisierung in verteilter Umgebung: SSO Protokoll

## 6.1 Zertifikat
  - Datenstruktur im Standardvormat X.509.v3
  - Bescheinigt Bundung von Public Key e_A an die Identity der Instanz/Subject A
  - Mit digitaler Signatur des Zertifikat-Ausstellers wird die Korrektheit der Daten bestaetigt

## 6.2 PKI - Public Key Infrastructure
### 6.2.1 Komponenten
  1. Registration Authority (RA): buergt fuer Verbindung zwischen public key und identity/attributen
  2. Certification Authority (CA): stellt zertifikate aus
  3. Validierungsstelle (VA): Check von Zertifikaten
  4. Verzeichnungsdienst: Verzeichnis mit ausgestellten Zertifikaten
  5. Personal Security Environment (PSE): Sichere Speicherung von private key

### 6.2.2 Hierarchie von CAs
  - Wurzel-Instanz (root) besitzt ein root Zertifikat 
  - Root Zertifikate sind selbstsigniert
  - Root CA stellt Zertifikate fuer untergeordnete CAs aus
  - Validierung laeuft ueber Zertifizierungspfad

## 6.3 Zertifikatvaldierung
  - check auf validity der signatur des zertifikats via  validierungspfad - jedes zertifikat auf dem pfad muss valid sein. D.h.:
    - Signatur ist valid
    - keine Nutzung veralteter Verfahren 
    - Zertifikat ist nicht revoced
    - Zertifikat ist nicht noch abgelaufen
    - Zertifizierungspfad ender bei einer trusted Root-CA
  - Beispielverfahren in SLIDES

## 6.4 Zertifizierungsrueckruf (Revocation)
  - Problem: Private Key ist wurde offengelegt oder invalid
  - Solution: *O*nline *C*ertifivate *S*tatus *P*rotocol (OCSP) Stapling
    - Server erfragt regelmaesig Gueltigkeits-Bestaetigung von CA
    - Bestaetigung ist mehrere requests valid
    - Server liefert Bestaetigung beim Verbindungsaufbau mit
## 6.5 Single-Sign-On (SSO)
  - Situation: 
    - Viele Dienste werden angeboten und jede Nutzung eines Dienstes erfordert eine Authentisierung
    - Jeder Dienst benoetigt Authentisierungsinformation ueber den Nutzer
  - Problem:
    - User muss fuer jeden DIenst seine Credentials uebertragen
    - Sensitive Zugangsdaten liegen auf vielen Rechnern
    - Verwendung des gleichen PWs: Komplromittierung ermoeglicht Zugriff auf alle Services mit gleichem Passwort

### 6.5.1 Solution: Single-Sign-on Konzept
Basis: Service AuC kennt Credentials und Shared Secrets
  1. For Zugriff auf Service S1: A authentisiert sich gegenueber AuC und erbittet eine Authenticitybescheinigung/Ticket fuer S1
  2. AuC erstellt Ticket fuer S1 und sendet dieses an A
  3. A reicht Ticket an S1 weiter 
  4. S1 prueft Ticket, fuehrt aber keine eigene Authentisierung durch

SSO: 
  - Trennung der
    - *Authentisierung* durch AuC: Policy-Decision-Point **PDP**
    - *Pruefung* auf *Validity* durch Service: Policy-Enforcement-Point **PEP**

### 6.5.2 SSO-Protokolle in der Praxis:
  - *Unternehmensnetzwerk*: Kerberos-Protokoll
  - *Web-Anwendungen*: OpenID Connect und OAuth
  - *Web-basiert, Akademia*: Shibboleth

#### Kerberos-Protokoll
  - AuC (idR als KDC bezeichnet) ist aufgeteilt in:
    - Ticket-Granting Service (TGS)
    - Authentication Service (AS)
  - Verwendet im Standard nur symmetrische Kryptographie
  - Pre-shared Master Key mit AuC for each User und Service
    - For User A: k_A wird aus pw von A abgeleitet
    - For Service S: k_S random generiert
  - Basiert auf 2 Kernkonzepten:
    - Ticket:fuer Zugriff auf einen Service wird ein Ticket benoetigt. Tickets werden vom TGS ausgestellt
      - T^(A,S) = (*S, A, addr, timestamp, lifetime, k_AS*)
      - *addr* ist die IP_Adresse von A
      - *timestamp*: Zeitpunkt der Ticketausstellung
      - *lifetime*: Dauer, wie lange T^(A,S) ab *timestamp* gueltig ist
      - Ticket wird von TGS mit Master-Key k_S von S encrypted: idR wird AES verwendet: AES_(k_S)(T^(A,S))
    - Authentikator: Nachweis des berechtigten Ticket-Besitzes
      - Instanz A legt Service S ein Ticket T^(A,S) vor
      - A muss S nachweisen, dass er der berechtigte Besitzer des Tickets T^(A,S) ist
      - A erzeugt die Authentikator-Datenstruktur Authent^A = *(A, addr, timestamp)*
      - Authenticator wird mit share key K_AS encrypted: AES_(k_AS)(Authent^A)
  - Ablauf:
    - *Initial*: Anfrage von A nach einem Initial-Ticket, um nachfolgend von TGS Tickets ausstellen zu lassen
      - Ausstellung des Initial-Tickets T^(A,TGS) fuer A und Authentisierung von A durch den Dienst AS des AuC: siehe SLIDES
        - A generiert k_A von ihrem Nutzer-PW
        - A stellt Ticket-Anfrage an AS zur Nutzung des TGS und authentisiert sich ueber die Kenntnis von k_A
        - AS checkt authenticity und erstellt Response
          - c2-Teil der Response enthaelt T^(A,TGS) encrypted mit shared key k_TGS
          - c1-Teil ist mit shared key k_A encrypted unf enthaelt die Challenge N1 von A sowie den neu generierten shared key k_(A, TGS) der fuer A und TGS vom AS-Service erzeugt wurde
        - A decrypted c1 und checkt Korrektheit der Response
    - *Wiederholt*: Ticket-Ausstellungs-Request fuer Dienst-Zugriff
      - Ausstellung eines Tickets T^(A,F) for A und den Zugriff auf Service F durch den TGS des AuC:
        - A besitit initialticket T^(A,TGS) for use of TGS and uses it to send the request: A erzeugt frische Callenge N2 und beweist mit dem Authenticator Authent1^A den berechtigten Besitz von T^(A,TGS)
        - TGS decrypts c2
          -  nutzt k_(A,TGS) um Authenticator in c3 zu decrypten und check ob Angaben in Auth1^A und in T^(A,TGS) stimmen
          -  generate new  Key for A and F: k_(A,F)
          -  erstellen von Response zur Challenge N2: c4 = AES_(k_A,TGS)(K_(A,F),N2,F)
       - TGS erstellt neues Ticket T^(A,F) und encrypted mit secret key von F: c5 = AES_(k_F)(T^(A,F))
       - A empfaengt encrypted messages c4 und c5
         - A decrypted c4 und checkt ob N2 die requested challenge ist und ob F der requested Servicename ist
         - A legt mit c5 F das Ticket T^(A,F) vor und beweist den berechtigten Besitz des Tickets durch Authent2^A und dessen encryption zu c6 mit k_(A,F)
         - F decrypted Ticket in c5 und checkt ob Ticket noch valid und Authent2^A korrekt ist

# Kapitel 7: Netzwerksicherheit
  - Transportsicherheit: Aufbau und Nutzung eines sicheren Kommunikationskanals, z.B.: Protokolle
  - Schutz der Endsysteme: Firewalls
## 7.1 Transportsicherheit: Sichere Verbindungen
### 7.1.1 Protokolle (SSL/TLS, IPSec, SSH, WPA2)
  - Untersch. Auspraegung umgesetzter Schutzziele
  - *Authentification:* ein-, wechselseitiig; per device oder per service/user 
  - *Vertraulichkeit:* 1 key pro Verbindung oder 1 Key pro Datenpaket
  - *Integrity:* Integrity des Verbindungsaufbaus oder pro Datenpaket
  - *Key Exchange:* Pre-shared Key, DH-Verfahren, RSA-Verfahren
  - *Verfahren:* Statisch festgelegte verfahren oder dynamische "Abstimmung" 

### 7.1.2 TLS 1.3 (*T*ransport *L*ayer *S*ecurity)
   - Industriestandard verwendet u.a. in HTTP absicherung -> HTTPS  oder SMTP over TLS
   - 5 Cyphersuiten festgelegt
     - TLS_AES_128_GCM_SHA256 
     - TLS_AES_256_GCM_SHA384
     - TLS_CHACHA20_POLY1305_SHA256
     - TLS_AES_128_CCM_SHA256
     - TLS_AES_128_CCM_8_SHA256
   - Key-Exchange: ECDH auf festgelegten Kurven
   - Authentisierung: X.509 Zertifikate
   - Digitale Signaturen: RSA, ECDSA
   - Protokolablauf
     1. Initial: Aufbau eines sicheren Kanals mit *Handshake-Protokoll(SIEHE SLIDES)*:
        - Abstimmen der Verfahren, der zu nutzenden Cipher-Suite
        - Authentsierung (Anonym, Ein-, Beidseitig)
        - Erzeugung zweier Communication Keys k_(a,b) k_(b,a) pro Richtung und eines MAC-Keys fuer den Handshake  
     2. Nutzung des Kanals: Encrypted Data
        - Application Data Protokoll: Datenpakete der Anwendung werden encrypted und versandt
        - Recipient decrypted und Anwendung verarbeitet Daten weiter

## 7.2 *V*irtual *P*rivate *N*etworks - *VPN*
  - Komponenten eines privaten Netzes kommunizieren via public Netz, besitzen Illusion dieses Netz zur alleinigen Verfuegung zu haben
  - Implementierungen: OpenVPN (TLS), IPSec, Wireguard
  - Bsp. Nutzung:
    - *End-to-Site-VPN:/Remote-Access-VPN*

## 7.3 Firewall-Architekturen
  - Netzwerk wird in versch. Netzsegmente unterteilt
  - An Grenzen Kontrolle durch Firewall:
    - Firewall-Regeln legen erlaubte Datenfluesse fest
    - Kontrolle der Einhaltung:
      - Ein- AUslasskontrolle for Packages  

### Types
**Paketfilter**
   - analysieren die Header des Datenpaketes nach Firewall regeln (z.B. iptables)
   - Aktion pro Datenpaket: accept, drop, reject

**Deep Packet Inspection - DPI**
   - Analyse von Paketheader und Nutzdaten hence Deep insection
   - Check auf Protokollverletzung und Malware possible
   - Missbrauchspotential: Zensur

**Application Layer Gateway - ALG / Proxy-Firewall**
   - Verbindung wird in Firewall terminiert und eine neue wird aufgebaut - Relay-Concept
   - Firewall hat Zugriff auf kompletten Connectionstate
   - kann aktiv in Connection eingreifen und Daten aendern 

# Kapitel 8: Autorisierung und Rechtemanagement

**Autorisierung:**
  - Verganbe von ZUgriffsberechtigungen und Kontrolle davon
  - Verhindern von unautorisierten Zugriffen

## 8.1 Introduction
  
**Basis:**
   - Authentisierung der zugreifenden Subjekte als Basis
   - Autorisierung: wer darf was!
  
**Aufgaben beim Rechtemanagement:**
   - Festlegen der Menge der *Zugriffsrechte*
   - Festlegen eines *Regelwerks* und *Kontrolle* der Zugriffe
   - (Dynam.) *Management* von Rechten: Berechtigung erteilen, einschraenken, entziehen, Zugriff verbieten
  
**Regelwerk (access policy):**
   - wer darf was, auf welche Weise, unter welchen Bedingungen nutzen (*permit*), bzw. nicht nutzen (*deny*)

**Zur umsetzung erforderliche Datenstrukturen/Kontrollen:**
  - Wer: Zugreifende Instanz identifizieren:
    - Subjekt: Nutzer, Prozess, Server, Service
  - Auf was soll zugegriffen werden: genutzte Ressource identifizieren:
    - Objekt (Assets): Datei, Datenbankeintrag, Page
  - Auf welche Weise zugreifen: Zugriffsrechte definieren:
    - Zugriffsrecht: r,w,x, Kamera_an, Internet_nutzen
  - Unter welchen Bedingungen nutzbar: Kontext spezifizieren:
    - Kontext/Attribute: Zweck, Rolle, Tageszeit, Alter
  
**Zentrale Prinzipien bei der Rechtevergabe:**
   1. Prinzip der *minimalen Rechte* (need-to-know, least priviledge): nur die Rechte vergeben, die zur Aufgabenerfuellung erforderlich sind
      - Lesson Learned: Die Modellierung von Rechten und das Management von Zugriffsrechten ist eine komplexe Aufgabe 
   2. Prinzip der *Complete Mediation, Zero Trust*: Jeder Zugriff auf eine geschuetzte Ressource ist zu kontrollieren.
    
  - Bem.:
    - Zero Trust: nicht nur Kontrolle am Perimeter (Firewall)
    - In der Praxis wird sehr haeufig gegen beide Prinzipien verstossen 
    - *IAM*: *I*dentity und *A*ccess *M*anagement-Dienst, also Authentisierungm Autorisierung, Audit (Protokoll)

**Modellierungsansaetze zur Vergabe von Zugriffsrechten:**
   - *D*iscretionary *A*ccess *C*ontrol (*DAC*): benutzerbestimmbare Vergabe/Ruecknahme, der Ressourcen-Owner bestimmt
   - *R*ole-based *A*ccess *C*ontrol (*RBAC*): Aufgaben-orientiert
   - *M*andatory *A*ccess *C*ontrol (*MAC*): systembestimmte Vergabe/Ruecknahme, globale, systemweite Regelungen

## 8.2 Klassische Modelle fuer das Rechtemanagement
## 8.2.1 Zugriffsmatrix-Modell
  - (Dyn.) Menge von Objekten O_t
  - (Dyn.) Menge von Subjekten S_t mit S_t sub O_t
  - Menge von Rechten R
  - Zugriffsmatrix M_t: S_t x O_t -> 2^R, Schutz Zustand zur Zeit t
  - Dynamik:
    - neue Subjekte
    - neue Objekte
    - Rechtevergabe/entzug
    - Delete
  - Bild in SLIDES
  
|+|-|
|---|---|
|Sehr einfaches Modell|Skaliert schlecht, Rechtevergabe orientiert sich an Subjekten, nicht an zu erledigenden Aufgaben|
|Einfach zu implementieren, z.B.: spalten-, zeilenweise| Verbesserung: Gruppenkonzept, Gruppe erhaelt Rechte|

## 8.2.2 Role-Based Access-Control
   - Rolle: beschreibt eine Aufgabe und die damit verbundenen Verantwortlichkeiten, Pflichten und Berechtigungen
   - RBAC ist in der Praxis sehr weit im Einsatz: ERP-Systeme wie SAP/Oracle-Software, MS Azure, Kubernetes
   - Modell:
     - Menge von Subjekten S_t, Menge von Objekten O_t
     - Menge von Rollen Role r, r in Role
     - Einem Subjekt ist eine Menge von ROllen zugeordnet: sr: S_t -> 2^(Role)
     - Menge P von Zugriffsrechten auf Objekte
     - Rolle ist Menge von Rechten zugeordnet: pr: Role -> 2^P
     - Nutze rs meldet sich mit einer seiner Rollen an r in sr(s), RL sub sr(s) ist die Menge der aktiven Rollen des Nutzers s
   - Rollenhierarchien:
     - Basis: Def. einer partiellen Ordnung <= auf der Menge Role
     - Vererbung der Rechte: hierarchisch hoehere Rollen erben die Rechte von tieferen Rollen
     - Vereinfachtes Rechtemanagement ueber Rollenhierarchie

|+|-
|---|---|
|gute modellierung unternehmerischer Strukturen|Vererbungskonzept verstoesst idR gegen need-to-know|
|gut skalierend in Bezug auf Veraenderungen bei Nutzern und deren Aufgabengebieten|Umsetzung: haeufig hunderte von Rollen zu verwalten|
|Rollen ind eher statisch, Rollenmitgliedschaften dynamisch:   - Nach einer Rollen-Zuweisung erhalten alle Mitglieder auomatisch alle zugeordneten Berechtigungen  - Wird eine Rolle entzogen, werden automatisch alle zugehoerigen Berechigungen entzogen||