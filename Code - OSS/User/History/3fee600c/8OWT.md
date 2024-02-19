# Integrity Codes
  - Mario Cagalj website nicht so helpful (http://marjan.fesb.hr/~mcagalj/), cool dude tho
  - sinn ist fehlererkennung von integrity durch encoding
  - All-Unidirectional Error-Detecting code - erkennt beliebeige anzahl an fehlern
  - wird benutzt wenn 0 in 1 gewandelt werden kann aber nicht andersrum
  - 3 main components - on-off keying, signal anti-blocking und I-coding
      - on-off: bit "1" moduliert durch presence of signal, "0" durch absence
      - signal anti-blocking: energie kann nicht ausgeloescht werden
      - I-codes:
          - triple (S,C,e)
              1. S ist endliche menge an moeglichen source states
              2. C ist endliche menge an binairy codewords
              3. e ist funktion S -> C, injektiv, unmoeglich codewort c zu c' zu machen mit c != c' ohne mind. ein bit "1" zu flippen
          - authentication through ptesence - enables message authentication based solely on the awareness of presence in the oiwer range of an entity
              - access point authentication
              - key establishment over insecure channels
          - delimiter - filler in payload der garantiert, dass codewords zwischen 2 delimiters authentic ist
              - codewords koennen nicht mit einem bitflip von 1 zu 0 zu delimiter gemacht werden und umgekehrt
              - jedes codeword zwischen zwei delimitern ist authentic
          - am besten fuer kurze nachrichten - robustness nimmt stark ab mit zunehmender size

---           

# Tamper Evident Pairing
  - TEA (tamper evident announcement)
      - designed for IEEE 801.11 Wi-Fi CSMA-CA
      - request by enrollee flag val 10
      - resply by registrar flag val 01
      - weil 10 und 01 immer unterscheidbar
      - ON-OFF Slots hart festgelegt
      - OFF kann zwar zu ON gemacht werden aber nicht umgekehrt -> aenderung leicht erkennbar
      - sync package longer als regular wifi transmitions 
      - payload ist random -> power kann nicht gecancled werden 
      - tampering entdeckt -> session overlap error und retry
  - In 802.11
      - erst CTS-to-Self und dann ON-OFF Slots
  - fixed I-code vulnerability
  - **ABER** relies on pbc, vllt iwie ohne pbc realisierbar?

---
      
# Secure In-Band Bootstrapping for Wireless Personal Area Networks
  - multi-party scenario
  - IGM - integrity guaranteed message - for IEEE 802.15.4
      - ON-OFF slots representing hash value of payload
      - |ON| = |OFF|
      - less communication overhead than I-codes and TEA
      - works in-band
      - consists of:
          1. structure
              - physical header
              - MAC header - first 3 bits 100 => data message, 101 => acknowledgement, 110 -> alarm message
              - payload
              - danach short interframe spacing, waehrend dessen receiver decodes and recognizes frame type
              - dann on-off bits
          2. self authenticated group key agreement protocol
              1. initialization phase:
                  - user gibt number of devices zu WPAN
                  - broadcast zu allen geraeten - weisst id zu, sendet request und zeigt start von secure bootstrapping process
                  - jedes device sendet ack
                  - alles mit IGM gesendet
              2. key agreement phase:
                  - devices compute and exchange keys via normal messages
                  - if no adversary, all devices derive the same key
              3. self-authentication phase:
                  - WPAN coordinator checks correctness of key
                  - compute and transmit hash val of key to coordinator 
          3. prescheduling mechanism for message transmition during self-auth. key agreement protocol exchange phase
              - use beacon-enabled superframe mode of IEEE 802.15.14 to preschedule
              - use GTS to schedule key agreement parameter transmission AND enables coordinator to know precise time of transmition
              - coordinator aborts if:
                  1. received IGM fails integrity check
                  2. alarm message is received
                  3. comparison of hashes fails

---                    
# Chorus: Scalable in-band Trust Establishment for Multiple Constrained Devices over the Insecure Wireless Channel
  - Related works: 
      - Physical-layer trust establishment:
          - RSS - randomness in received signal strength to extract secret key between devices
          - ensuring close device proximity
          - location distinction
          - device identification
      - Message AUthentication and Integrity Protection
          - (I)-codes
          - TEP
          - both only weak security guarantee
          - TEA delay can be critical in many real-world applications
  - contributions:
    

---
# Investigation of Signal and Message Manipulations on the Wireless Channel


---

# Message Integrity Protection over Wireless Channel
  - mentions (I)-Codes and TEP as related work
  - Poepper demonstrated a practical attack against it
  - Chorus by Hou

---

# Helper-Enabled In-Band Device Pairing
  - same as above
  - maybe continuation of tep

---
# SFIRE: Secret-Free In-band Trust Establishment for COTS Wireless Devices



---
# Research Questions:
  - Mechanismen die dem bissle aehnlich sind?
  - TEP relies on PBC, geht auch iwie ohne?
  - Integrity codes for shorter messages?

---

# Arbeit
 - SOK
 - Sammlung von Protokollen und mechanismen zu I codes und tep und zeug das eben weiterfuehrend ist
 - am ende conclusion und vergleich 
 
