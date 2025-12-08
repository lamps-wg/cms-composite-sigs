---
title: Composite ML-DSA for use in Cryptographic Message Syntax (CMS)
abbrev: Composite ML-DSA CMS
docname: draft-ietf-lamps-cms-composite-sigs-latest

stand_alone: true # This lets us do fancy auto-generation of references
ipr: trust200902
area: Security
wg: LAMPS
cat: std
submissiontype: IETF  # also: "independent", "editorial", "IAB", or "IRTF"
keyword:
  - cms
  - composite ml-dsa
venue:
  group: LAMPS
  type: Working Group
  mail: spams@ietf.org
  arch: https://datatracker.ietf.org/wg/lamps/about/
  github: "lamps-wg/cms-composite-sigs"
  latest: "https://lamps-wg.github.io/cms-composite-sigs/draft-ietf-lamps-cms-composite-sigs.html"

author:
  -
    ins: M. Ounsworth
    name: Mike Ounsworth
    org: Entrust Limited
    abbrev: Entrust
    street: 2500 Solandt Road – Suite 100
    city: Ottawa, Ontario
    country: Canada
    code: K2K 3G5
    email: mike.ounsworth@entrust.com
  -
    ins: J. Gray
    name: John Gray
    org: Entrust Limited
    abbrev: Entrust
    street: 2500 Solandt Road – Suite 100
    city: Ottawa, Ontario
    country: Canada
    code: K2K 3G5
    email: john.gray@entrust.com
  -
    ins: J. Klaussner
    name: Jan Klaussner
    org: Bundesdruckerei GmbH
    email: jan.klaussner@bdr.de
    street: Kommandantenstr. 18
    code: 10969
    city: Berlin
    country: Germany
  -
    ins: D. Van Geest
    name: Daniel Van Geest
    org: CryptoNext Security
    email: daniel.vangeest@cryptonext-security.com
    street: ‍16, Boulevard Saint-Germain
    code: 75007
    city: Paris
    country: France


normative:
  FIPS180: DOI.10.6028/NIST.FIPS.180-4
  FIPS202: DOI.10.6028/NIST.FIPS.202
  FIPS204: DOI.10.6028/NIST.FIPS.204


informative:
  X680:
    target: https://www.itu.int/rec/T-REC-X.680
    title: >
      Information technology - Abstract Syntax Notation One (ASN.1): Specification of basic notation
    author:
      org: ITU-T
    date: February 2021
    seriesinfo:
      ITU-T Recommendation: X.680
      ISO/IEC: 8824-1:2021


--- abstract

Composite ML-DSA defines combinations of ML-DSA, as defined by NIST in FIPS 204, with RSA, ECDSA, and EdDSA.
This document specifies the conventions for using Composite ML-DSA within the Cryptographic Message Syntax (CMS).


--- middle


# Introduction {#sec-intro}

{{!I-D.ietf-lamps-pq-composite-sigs}} defines a collection of signature algorithms, referred to as Composite ML-DSA, which combine ML-DSA {{FIPS204}} with traditional algorithms RSASSA-PKCS1-v1.5, RSASSA-PSS, ECDSA, Ed25519, and Ed448.
This document acts as a companion to {{I-D.ietf-lamps-pq-composite-sigs}} by providing conventions for using Composite ML-DSA algorithms within the Cryptographic Message Syntax (CMS) {{!RFC5652}}.


## Conventions and Terminology {#sec-terminology}

{::boilerplate bcp14+}

This document is consistent with the terminology defined in {{?RFC9794}}.


# Composite ML-DSA Algorithm Identifiers {#algorithm-identifiers}

Many ASN.1 data structure types use the AlgorithmIdentifier type to identify cryptographic algorithms.
In the CMS, AlgorithmIdentifiers are used to identify Composite ML-DSA signatures in the signed-data content type.
They may also appear in X.509 certificates used to verify those signatures.
The same AlgorithmIdentifiers are used to identify Composite ML-DSA public keys and signature algorithms.
{{I-D.ietf-lamps-pq-composite-sigs}} describes the use of Composite ML-DSA in X.509 certificates.
The AlgorithmIdentifier type is defined as follows:

~~~ asn.1
AlgorithmIdentifier{ALGORITHM-TYPE, ALGORITHM-TYPE:AlgorithmSet} ::=
        SEQUENCE {
            algorithm   ALGORITHM-TYPE.&id({AlgorithmSet}),
            parameters  ALGORITHM-TYPE.
                   &Params({AlgorithmSet}{@algorithm}) OPTIONAL
        }
~~~

<aside markdown="block">
  NOTE: The above syntax is from {{!RFC5911}} and is compatible with the
  2021 ASN.1 syntax {{X680}}. See {{?RFC5280}} for the 1988 ASN.1 syntax.
</aside>

The fields in the AlgorithmIdentifier type have the following meanings:

algorithm:

: The algorithm field contains an OID that identifies the cryptographic algorithm in use.
The OIDs for Composite ML-DSA are described below.

parameters:

: The parameters field contains parameter information for the algorithm identified by the OID in the algorithm field.
Each Composite ML-DSA parameter set is identified by its own algorithm OID, so there is no relevant information to include in this field.
As such, parameters MUST be omitted when encoding a Composite ML-DSA AlgorithmIdentifier.

The object identifiers for Composite ML-DSA are defined in {{I-D.ietf-lamps-pq-composite-sigs}}, and are reproduced here for convenience.

~~~ asn.1
id-MLDSA44-RSA2048-PSS-SHA256 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 37 }
id-MLDSA44-RSA2048-PKCS15-SHA256 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 38 }
id-MLDSA44-Ed25519-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 39 }
id-MLDSA44-ECDSA-P256-SHA256 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 40 }
id-MLDSA65-RSA3072-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 41 }
id-MLDSA65-RSA3072-PKCS15-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 42 }
id-MLDSA65-RSA4096-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 43 }
id-MLDSA65-RSA4096-PKCS15-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 44 }
id-MLDSA65-ECDSA-P256-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 45 }
id-MLDSA65-ECDSA-P384-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 46 }
id-MLDSA65-ECDSA-brainpoolP256r1-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 47 }
id-MLDSA65-Ed25519-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 48 }
id-MLDSA87-ECDSA-P384-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 49 }
id-MLDSA87-ECDSA-brainpoolP384r1-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 50 }
id-MLDSA87-Ed448-SHAKE256 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 51 }
id-MLDSA87-RSA3072-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 52 }
id-MLDSA87-RSA4096-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 53 }
id-MLDSA87-ECDSA-P521-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) org(3) dod(6) internet(1) security(5) mechanisms(5)
   pkix(7) alg(6) 54 }
~~~

# Signed-Data Conventions

## Pre-Hashing

{{RFC5652}} specifies that digital signatures for CMS are produced using a digest of the message to be signed and the signer's private key.
At the time RFC 5652 was published, all signature algorithms supported in the CMS required a message digest to be calculated externally to that algorithm, which would then be supplied to the algorithm implementation when calculating and verifying signatures.
Since then, EdDSA {{?RFC8032}} and ML-DSA {{FIPS204}} have also been standardised, and these algorithms support both a "pure" and "pre-hash" mode, although their use in CMS has only been defined for "pure" mode.

Composite ML-DSA operates only in a "pre-hash" mode, however unlike RSA and ECDSA each Composite ML-DSA algorithm is defined to be used with a single digest algorithm which is identified in the Composite ML-DSA algorithm name.
For example, id-MLDSA87-ECDSA-P521-SHA512 uses SHA-512 as its digest.

When Composite ML-DSA is used in CMS, the digest algorithm used by CMS is the same digest algorithm used by the Composite ML-DSA algorithm.


## Signature Generation and Verification

{{RFC5652}} describes the two methods that are used to calculate and verify signatures in the CMS.
One method is used when signed attributes are present in the signedAttrs field of the relevant SignerInfo, and another is used when signed attributes are absent.
Use of signed attributes is preferred, but the conventions for signed-data without signed attributes is also described below for completeness.

When signed attributes are absent, Composite ML-DSA signatures are computed over the content of the signed-data.
As described in {{Section 5.4 of RFC5652}}, the "content" of a signed-data is the value of the encapContentInfo eContent OCTET STRING.
The tag and length octets are not included.

When signed attributes are included, Composite ML-DSA signatures are computed over the complete DER encoding of the SignedAttrs value contained in the SignerInfo's signedAttrs field.
As described in {{Section 5.4 of RFC5652}}, this encoding includes the tag and length octets, but an EXPLICIT SET OF tag is used rather than the IMPLICIT \[0\] tag that appears in the final message.
At a minimum, the signedAttrs field MUST include a content-type attribute and a message-digest attribute.
The message-digest attribute contains a hash of the content of the signed-data, where the content is as described for the absent signed attributes case above.
Recalculation of the hash value by the recipient is an important step in signature verification.

Composite ML-DSA has a context string input that can be used to ensure that different signatures are generated for different application contexts.
When using Composite ML-DSA as specified in this document, the context string is set to the empty string.


## SignerInfo Content

When using Composite ML-DSA, the fields of a SignerInfo are used as follows:

digestAlgorithm:

: Per {{Section 5.3 of RFC5652}}, the digestAlgorithm field identifies the message digest algorithm used by the signer and any associated parameters.
This MUST be the same digest algorithm used by the Composite ML-DSA algorithm.
See {{digest-algs}} for exact algorithm mappings.

: {{!RFC5754}} defineds the use of SHA-256 {{FIPS180}} (id-sha256) and SHA-512 {{FIPS180}} (id-sha512) in CMS. {{!RFC8702}} defines the used of SHAKE256 {{FIPS202}} in CMS (id-shake256).
When id-sha256 or id-sha512 is used, the parameters field MUST be omitted.
When id-shake256 is used the parameters field MUST be omitted and the digest length MUST be 64 bytes.

| Signature Algorithm                     | Digest Algorithms |
| id-MLDSA44-RSA2048-PSS-SHA256           | id-sha256         |
| id-MLDSA44-RSA2048-PKCS15-SHA256        | id-sha256         |
| id-MLDSA44-Ed25519-SHA512               | id-sha512         |
| id-MLDSA44-ECDSA-P256-SHA256            | id-sha256         |
| id-MLDSA65-RSA3072-PSS-SHA512           | id-sha512         |
| id-MLDSA65-RSA3072-PKCS15-SHA512        | id-sha512         |
| id-MLDSA65-RSA4096-PSS-SHA512           | id-sha512         |
| id-MLDSA65-RSA4096-PKCS15-SHA512        | id-sha512         |
| id-MLDSA65-ECDSA-P256-SHA512            | id-sha512         |
| id-MLDSA65-ECDSA-P384-SHA512            | id-sha512         |
| id-MLDSA65-ECDSA-brainpoolP256r1-SHA512 | id-sha512         |
| id-MLDSA65-Ed25519-SHA512               | id-sha512         |
| id-MLDSA87-ECDSA-P384-SHA512            | id-sha512         |
| id-MLDSA87-ECDSA-brainpoolP384r1-SHA512 | id-sha512         |
| id-MLDSA87-Ed448-SHAKE256               | id-shake256       |
| id-MLDSA87-RSA3072-PSS-SHA512           | id-sha512         |
| id-MLDSA87-RSA4096-PSS-SHA512           | id-sha512         |
| id-MLDSA87-ECDSA-P521-SHA512            | id-sha512         |
{: #digest-algs title="Digest Algorithms for Composite ML-DSA"}

signatureAlgorithm:

 : The signatureAlgorithm field MUST contain one of the Composite ML-DSA signature algorithm OIDs, and the parameters field MUST be absent. The algorithm OID MUST be one of the OIDs described in {{algorithm-identifiers}}.

 signature:

 : The signature field contains the signature value resulting from the use of the Composite ML-DSA signature algorithm identified by the signatureAlgorithm field.
 The Composite ML-DSA signature-generation operation is specified in {{Section 4.2 of I-D.ietf-lamps-pq-composite-sigs}}, and the signature-verification operation is specified in {{Section 4.3 of I-D.ietf-lamps-pq-composite-sigs}}.
 Note that {{Section 5.6 of RFC5652}} places further requirements on the successful verification of a signature.

# ASN.1 Module {#sec-asn1-module}

~~~ asn.1
<CODE BEGINS>
{::include Composite-MLDSA-CMS-2026.asn}
<CODE ENDS>
~~~


# IANA Considerations {#sec-iana}
IANA is requested to allocate a value from the "SMI Security for PKIX Module Identifier" registry for the included ASN.1 module.

-  Decimal: IANA Assigned - **Replace TBDCompositeMOD**
-  Description: Composite-Signatures-CMS-2026 - id-mod-composite-mldsa-cms-2026
-  References: This Document


<!-- End of IANA Considerations section -->


# Security Considerations

All security considerations from {{I-D.ietf-lamps-pq-composite-sigs}} apply.

Security of the Composite ML-DSA private key is critical.
Compromise of the private key will enable an adversary to forge arbitrary signatures.

Composite ML-DSA depends on high-quality random numbers that are suitable for use in cryptography.
The use of inadequate pseudo-random number generators (PRNGs) to generate such values can significantly undermine the security properties offered by a cryptographic algorithm.
For instance, an attacker may find it much easier to reproduce the PRNG environment that produced any private keys, searching the resulting small set of possibilities, rather than brute-force searching the whole key space.
The generation of random numbers of a sufficient level of quality for use in cryptography is difficult; see Section 3.6.1 of {{FIPS204}} for some additional information.

To avoid algorithm substitution attacks, the CMSAlgorithmProtection attribute defined in {{!RFC6211}} SHOULD be included in signed attributes.


--- back


# Examples

This appendix contains example signed-data encodings with the id-MLDSA65-ECDSA-P256-SHA512 signature algorithm.

They can be verified using the example public keys and certificates specified in {{Appendix E of I-D.ietf-lamps-pq-composite-sigs}}.
Specifically, the following example:

- tcId: id-MLDSA65-ECDSA-P256-SHA512
- x5c: Base64 of the DER encoding of the certificate.  Write this in PEM headers and footers to get a PEM certificate.

The following is an example of a signed-data with a single id-MLDSA65-ECDSA-P256-SHA512 signer, with signed attributes included:

~~~
{::include ./examples/id-MLDSA65-ECDSA-P256-SHA512-signed-attrs.pem}
~~~

~~~
{::include ./examples/id-MLDSA65-ECDSA-P256-SHA512-signed-attrs.txt}
~~~

# Acknowledgements
{:numbered="false"}

TODO -- update this.


This document borrows text from similar documents, including those referenced below. Thanks go to the authors of those
   documents.  "Copying always makes things easier and less error prone" - {{?RFC8411}}.

