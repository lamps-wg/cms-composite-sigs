---
title: Composite Module-Lattice-Based Digital Signature Algorithm (ML-DSA) for use in Cryptographic Message Syntax (CMS)
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
  FIPS.180: DOI.10.6028/NIST.FIPS.180-4
  FIPS.202: DOI.10.6028/NIST.FIPS.202
  FIPS.204: DOI.10.6028/NIST.FIPS.204
  FIPS.186-5: DOI.10.6028/NIST.FIPS.186-5
  X680:
    target: https://www.itu.int/rec/T-REC-X.680
    title: >
      Information technology - Abstract Syntax Notation One (ASN.1):
      Specification of basic notation
    date: 2021-02
    author:
    -  org: ITU-T
    seriesinfo:
      ITU-T Recommendation: X.680
      ISO/IEC: 8824-1:2021
  X690:
    target: https://www.itu.int/rec/T-REC-X.690
    title: >
      Information technology - Abstract Syntax Notation One (ASN.1):
      ASN.1 encoding rules: Specification of Basic Encoding Rules (BER),
      Canonical Encoding Rules (CER) and Distinguished Encoding Rules (DER)
    date: 2021-02
    author:
    -  org: ITU-T
    seriesinfo:
      ITU-T Recommendation: X.690
      ISO/IEC: 8825-1:2021


informative:

--- abstract

Composite Module-Lattice-Based Digital Signature Algorithm (ML-DSA) defines combinations of ML-DSA with RSA, ECDSA, and EdDSA.
This document specifies the conventions for using Composite ML-DSA algorithms within the Cryptographic Message Syntax (CMS).


--- middle


# Introduction {#sec-intro}

{{!I-D.ietf-lamps-pq-composite-sigs}} defines a collection of signature algorithms, referred to as Composite ML-DSA, which combine ML-DSA {{FIPS.204}} with RSASSA-PKCS1-v1.5 {{!RFC8017}}, RSASSA-PSS {{!RFC8017}}, ECDSA (Section 6 of {{!FIPS.186-5}}), Ed25519 {{!RFC8410}}, and Ed448 {{!RFC8410}}.
This document acts as a companion to {{I-D.ietf-lamps-pq-composite-sigs}} by providing conventions for using Composite ML-DSA algorithms within the Cryptographic Message Syntax (CMS) {{!RFC5652}}.


## ASN.1

CMS values are generated using ASN.1 {{X680}}, using the Basic Encoding Rules (BER) and the Distinguished Encoding Rules (DER) {{X690}}.

## Conventions and Terminology {#sec-terminology}

{::boilerplate bcp14+}


# Composite ML-DSA Algorithm Identifiers {#algorithm-identifiers}

The same AlgorithmIdentifier is used to identify a Composite ML-DSA public key and signature algorithm.
The object identifiers for Composite ML-DSA algorithms are defined in {{I-D.ietf-lamps-pq-composite-sigs}}, and are reproduced here for convenience.
The parameters field of the AlgorithmIdentifier for the Composite ML-DSA public key and signature algorithm MUST be absent.

~~~ asn.1
id-MLDSA44-RSA2048-PSS-SHA256 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 37 }
id-MLDSA44-RSA2048-PKCS15-SHA256 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 38 }
id-MLDSA44-Ed25519-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 39 }
id-MLDSA44-ECDSA-P256-SHA256 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 40 }
id-MLDSA65-RSA3072-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 41 }
id-MLDSA65-RSA3072-PKCS15-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 42 }
id-MLDSA65-RSA4096-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 43 }
id-MLDSA65-RSA4096-PKCS15-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 44 }
id-MLDSA65-ECDSA-P256-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 45 }
id-MLDSA65-ECDSA-P384-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 46 }
id-MLDSA65-ECDSA-brainpoolP256r1-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 47 }
id-MLDSA65-Ed25519-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 48 }
id-MLDSA87-ECDSA-P384-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 49 }
id-MLDSA87-ECDSA-brainpoolP384r1-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 50 }
id-MLDSA87-Ed448-SHAKE256 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 51 }
id-MLDSA87-RSA3072-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 52 }
id-MLDSA87-RSA4096-PSS-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 53 }
id-MLDSA87-ECDSA-P521-SHA512 OBJECT IDENTIFIER ::= {
   iso(1) identified-organization(3) dod(6) internet(1) security(5)
   mechanisms(5) pkix(7) alg(6) 54 }
~~~

# Signed-Data Conventions

## Pre-Hashing

{{RFC5652}} specifies that digital signatures for CMS are produced using a digest of the message to be signed and the signer's private key.
At the time {{RFC5652}} was published, all signature algorithms supported in the CMS required a message digest to be calculated externally to that algorithm, which would then be supplied to the algorithm implementation when calculating and verifying signatures.
Since then, EdDSA {{?RFC8032}} and ML-DSA {{FIPS.204}} have also been standardized, and these algorithms support both a "pure" and "pre-hash" mode, although their use in CMS has only been defined for "pure" mode.

Composite ML-DSA only provides a "pre-hash" mode. Unlike RSA and ECDSA each Composite ML-DSA algorithm is defined to be used with a single digest algorithm which is identified in the Composite ML-DSA algorithm name.
For example, id-MLDSA87-ECDSA-P521-SHA512 uses SHA-512 as its pre-hash digest algorithm.

When Composite ML-DSA is used in CMS, the digest algorithm used by CMS SHALL be the same pre-hash digest algorithm used by the Composite ML-DSA algorithm.  A Composite ML-DSA algorithm might use additional digest algorithms internally, e.g., in the case of id-MLDSA87-ECDSA-P384-SHA512 the ECDSA component uses SHA-384. These internal digest algorithms are irrelevant to Composite ML-DSA's use in CMS.


## SignedData digestAlgorithms

The SignedData digestAlgorithms field includes the identifiers of the message digest algorithms used by one or more signer.
When signing with a Composite ML-DSA algorithm, this list of identifiers SHOULD include the corresponding digest algorithm from {{digest-algs}}.
The field is intended to list the message digest algorithms employed by all of the signers, to facilitate one-pass signature verification.
If the corresponding digest algorithm from {{digest-algs}} is not listed, a one-pass verifier might not successfully verify the Composite ML-DSA signature.


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


## SignerInfo Content {#sec-signerinfo}

When using Composite ML-DSA, the fields of a SignerInfo are used as follows:

digestAlgorithm:

: Per {{Section 5.3 of RFC5652}}, the digestAlgorithm field identifies the message digest algorithm used by the signer and any associated parameters.
This MUST be the same digest algorithm used by the Composite ML-DSA algorithm.
Per {{!RFC8933}}, if the signedAttrs field is present in the SignerInfo, then the same digest algorithm MUST be used to compute both the digest of the SignedData encapContentInfo eContent, which is carried in the message-digest attribute, and the digest of the DER-encoded signedAttrs, which is passed to the signature algorithm.
See {{digest-algs}} for exact algorithm mappings.

: {{!RFC5754}} defines the use of SHA-256 {{FIPS.180}} (id-sha256) and SHA-512 {{FIPS.180}} (id-sha512) in CMS. {{!RFC8702}} defines the use of SHAKE256 {{FIPS.202}} (id-shake256) in CMS.
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


# IANA Considerations {#sec-iana}
IANA is requested to allocate a value from the "SMI Security for S/MIME Module Identifier (1.2.840.113549.1.9.16.0)" registry for the included ASN.1 module.

-  Decimal: IANA Assigned - **Replace TBDMOD**
-  Description: Composite-MLDSA-CMS-2026 - id-mod-composite-mldsa-cms-2026
-  References: This Document


<!-- End of IANA Considerations section -->


# Security Considerations

All security considerations from {{I-D.ietf-lamps-pq-composite-sigs}} apply.

Security of the Composite ML-DSA private key is critical.
Compromise of the private key will enable an adversary to forge arbitrary signatures.

Composite ML-DSA depends on high-quality random numbers that are suitable for use in cryptography.
The use of inadequate pseudo-random number generators (PRNGs) to generate such values can significantly undermine the security properties offered by a cryptographic algorithm.
For instance, an attacker may find it much easier to reproduce the PRNG environment that produced any private keys, searching the resulting small set of possibilities, rather than brute-force searching the whole key space.
The generation of random numbers of a sufficient level of quality for use in cryptography is difficult; see Section 3.6.1 of {{FIPS.204}} for some additional information.

To avoid algorithm substitution attacks, the CMSAlgorithmProtection attribute defined in {{!RFC6211}} SHOULD be included in signed attributes.

{{sec-signerinfo}} specifies that the SignerInfo digestAlgorithm field MUST contain the Composite ML-DSA algorithm's pre-hash algorithm.
If the digestAlgorithm and pre-hash algorithm don't match, the verifier SHOULD reject the message as invalid CMS, but for backwards-compatibility or interoperability reasons MAY verify the signature using the pre-hash algorithm.
If these algorithms don't match, this implies that the signer may have passed an incorrect digest value to the Composite ML-DSA signing algorithm and the resulting signature would not be valid for the data being signed.
This is a general issue with CMS, where a SignerInfo's digestAlgorithm field might not correspond to the digest required by the SignerInfo's signatureAlgorithm field.

ECDSA, EdDSA, and RSA signatures are relatively small compared to ML-DSA signatures, and thus compared to Composite ML-DSA signatures as well.
On the other hand, Composite ML-DSA signatures are not that much larger than ML-DSA signatures.
When moving from ECDSA, EdDSA, or RSA to Composite ML-DSA (or ML-DSA), the resulting increased message sizes could stress size-constrained processing pipelines.

ECDSA (with curve secp256r1) and Ed25519 have very fast signing operations compared to ML-DSA (and thus Composite ML-DSA).
Implementations which rely on this fast signing should be aware of potential denial of service issues arising from the slower signing times.

--- back

# ASN.1 Module {#sec-asn1-module}

This appendix includes the ASN.1 module {{X680}} for the use of ML-KEM in the CMS.
This module imports objects from {{!RFC5911}}.

~~~ asn.1
<CODE BEGINS>
{::include Composite-MLDSA-CMS-2026.asn}
<CODE ENDS>
~~~


# Examples

This appendix contains an example signed-data encoding with the id-MLDSA65-ECDSA-P256-SHA512 signature algorithm.

It can be verified using the example public keys and certificates specified in {{Appendix E of I-D.ietf-lamps-pq-composite-sigs}}.
Specifically, the following example:

- tcId: id-MLDSA65-ECDSA-P256-SHA512
- x5c: Base64 of the DER encoding of the certificate.  Wrap this in PEM headers and footers to get a PEM certificate.

To keep example size down, the signing certificate is not included in the CMS encoding.
The example certificate from {{I-D.ietf-lamps-pq-composite-sigs}} used to sign the CMS content is self-signed.

The following is an example of a signed-data with a single id-MLDSA65-ECDSA-P256-SHA512 signer, with signed attributes included:

~~~
{::include ./examples/id-MLDSA65-ECDSA-P256-SHA512-signed-attrs.pem}
~~~

~~~
{::include ./examples/id-MLDSA65-ECDSA-P256-SHA512-signed-attrs.txt}
~~~

# Acknowledgements
{:numbered="false"}

The authors wish to thank Piotr Popis (Enigma) for his valuable feedback on this document.

Thanks to the co-authors of {{?RFC9882}}, Ben Salter and Adam Raine, this document borrows heavily
from that one. "Copying always makes things easier and less error prone" - {{?RFC8411}}.

