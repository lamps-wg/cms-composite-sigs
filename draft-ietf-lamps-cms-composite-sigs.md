---
title: Composite ML-DSA for use in Cryptographic Message Syntax (CMS)
abbrev: Composite ML-DSA CMS
docname: draft-ietf-lamps-cms-composite-sigs-latest

ipr: trust200902
area: Security
wg: LAMPS
kw: Internet-Draft
cat: std
submissiontype: IETF  # also: "independent", "editorial", "IAB", or "IRTF"

venue:
  group: LAMPS
  type: Working Group
  mail: spams@ietf.org
  arch: https://datatracker.ietf.org/wg/lamps/about/
  github: lamps-wg/draft-composite-sigs
  latest: https://lamps-wg.github.io/draft-composite-sigs/draft-ietf-lamps-pq-composite-sigs.html

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



normative:
  RFC2119:
  RFC2986:
  RFC4210:
  RFC4211:
  RFC4262:
  RFC5280:
  RFC5480:
  RFC5639:
  RFC5652:
  RFC5758:
  RFC5958:
  RFC6090:
  RFC6234:
  RFC7748:
  RFC8032:
  RFC8174:
  RFC8410:
  RFC8411:
  I-D.draft-ietf-lamps-pq-composite-sigs-13:
  X.690:
      title: "Information technology - ASN.1 encoding Rules: Specification of Basic Encoding Rules (BER), Canonical Encoding Rules (CER) and Distinguished Encoding Rules (DER)"
      date: November 2015
      author:
        org: ITU-T
      seriesinfo:
        ISO/IEC: 8825-1:2015
  FIPS.180:
    title: "Secure Hash Standard (SHS)"
    date: August 2015
    author:
      org: "National Institute of Standards and Technology (NIST)"
    target: https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf
  FIPS.186-5:
    title: "Digital Signature Standard (DSS)"
    date: February 3, 2023
    author:
      org: "National Institute of Standards and Technology (NIST)"
    target: https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-5.pdf
  FIPS.204:
    title: "Module-Lattice-Based Digital Signature Standard"
    date: August 13, 2024
    author:
      org: "National Institute of Standards and Technology (NIST)"
    target: https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf


informative:
  RFC3279:
  RFC5914:
  RFC7292:
  RFC7296:
  RFC7299:
  RFC8446:
  RFC8551:
  RFC8017:
  RFC9794: # I-D.draft-ietf-pquip-pqt-hybrid-terminology-04:
  RFC9881: # I-D.draft-ietf-lamps-dilithium-certificates-04:
  RFC9882: # I-D.draft-ietf-lamps-cms-ml-dsa-02:
  I-D.draft-ietf-pquip-hybrid-signature-spectrums-07:
  Bindel2017:
    title: "Transitioning to a quantum-resistant public key infrastructure"
    target: "https://link.springer.com/chapter/10.1007/978-3-319-59879-6_22"
    author:
      -
        ins: N. Bindel
        name: Nina Bindel
      -
        ins: U. Herath
        name: Udyani Herath
      -
        ins: M. McKague
        name: Matthew McKague
      -
        ins: D. Stebila
        name: Douglas Stebila
    date: 2017
  BSI2021:
    title: "Quantum-safe cryptography - fundamentals, current developments and recommendations"
    target: https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Brochure/quantum-safe-cryptography.pdf
    author:
      - org: "Federal Office for Information Security (BSI)"
    date: October 2021
  ANSSI2024:
    title: "Position Paper on Quantum Key Distribution"
    target: https://cyber.gouv.fr/sites/default/files/document/Quantum_Key_Distribution_Position_Paper.pdf
    author:
      - org: "French Cybersecurity Agency (ANSSI)"
      - org: "Federal Office for Information Security (BSI)"
      - org: "Netherlands National Communications Security Agency (NLNCSA)"
      - org: "Swedish National Communications Security Authority, Swedish Armed Forces"



--- abstract

This document defines conventions for using Composite ML-DSA within the Cryptographic Message Syntax (CMS).


--- middle


# Introduction {#sec-intro}

This document acts as a companion to {{I-D.ietf-lamps-pq-composite-sigs}} by providing conventions for using the Composite ML-DSA algorithm within the Cryptographic Message Syntax (CMS).



## Conventions and Terminology {#sec-terminology}

{::boilerplate bcp14+}

This document is consistent with the terminology defined in [rfc9794]. In addition, the following terminology is used throughout this document:

**ALGORITHM**:
          The usage of the term "algorithm" within this
          document generally refers to any function which
          has a registered Object Identifier (OID) for
          use within an ASN.1 AlgorithmIdentifier. This
          loosely, but not precisely, aligns with the
          definitions of "cryptographic algorithm" and
          "cryptographic scheme" given in [rfc9794].

**BER**:
          Basic Encoding Rules (BER) as defined in [X.690].

**CLIENT**:
          Any software that is making use of a cryptographic key.
          This includes a signer, verifier, encrypter, decrypter.
          This is not meant to imply any sort of client-server
          relationship between the communicating parties.

**DER**:
          Distinguished Encoding Rules as defined in [X.690].

**PKI**:
          Public Key Infrastructure, as defined in [RFC5280].

**PUBLIC / PRIVATE KEY**:
          The public and private portion of an asymmetric cryptographic
          key, making no assumptions about which algorithm.

**SIGNATURE**:
          A digital cryptographic signature, making no assumptions
            about which algorithm.



# Use in CMS

Composite Signature algorithms MAY be employed for one or more recipients in the CMS signed-data content type [RFC5652].

All recommendations for using Composite ML-DSA in CMS are fully aligned with the use of ML-DSA in CMS [RFC9882].

## Underlying Components {#cms-underlying-components}

A compliant implementation MUST support SHA-512 [FIPS.180] for all composite variants in this document. Implementations MAY also support other algorithms for the SignerInfo `digestAlgorithm` and SHOULD use algorithms that produce a hash value of a size that is at least twice the collision strength of the internal commitment hash used by ML-DSA.

Note: The Hash ML-DSA Composite identifiers are relevant here because this algorithm operation mode is not provided in CMS, which is consistent with [RFC9882].


TODO -- DO we need to specify mandatory-to-implement digest algorithms, the same way we specify KDF algs for KEMs?

## SignedData Conventions

As specified in CMS [RFC5652], the digital signature is produced from the message digest and the signer's private key. The signature is computed over different values depending on whether signed attributes are absent or present.

When signed attributes are absent, the composite signature is computed over the content of the signed-data. The "content" of a signed-data is the value of the encapContentInfo eContent OCTET STRING. The tag and length octets are not included.
When signed attributes are present, a hash is computed over the content using the hash function specified in {{cms-underlying-components}}, and then a message-digest attribute is constructed to contain the resulting hash value, and then the result of DER encoding the set of signed attributes, which MUST include a content-type attribute and a message-digest attribute, and then the composite signature is computed over the DER-encoded output. In summary:

~~~
IF (signed attributes are absent)
   THEN Composite-ML-DSA.Sign(content)
ELSE message-digest attribute = Hash(content);
   Composite-ML-DSA.Sign(DER(SignedAttributes))
~~~

When using Composite Signatures, the fields in the SignerInfo are used as follows:

digestAlgorithm:
    Per Section 5.3 of [RFC5652], the digestAlgorithm contains the one-way hash function used by the CMS signer.
    To ensure collision resistance, the identified message digest algorithm SHOULD produce a hash
    value of a size that is at least twice the collision strength of the internal commitment hash used by ML-DSA
    component algorithm of the Composite Signature.

signatureAlgorithm:
    The signatureAlgorithm MUST contain one of the the Composite Signature algorithm identifiers as specified in {{cms-underlying-components}}}

signature:
    The signature field contains the signature value resulting from the composite signing operation of the specified signatureAlgorithm.


## Signature generation and verification

Composite signatures have a context string input that can be used to ensure that different signatures are generated for different application contexts.  When using composite signatures for CMS, the context string is the empty string.


## Certificate Conventions

The conventions specified in this section augment RFC 5280 [RFC5280].

The willingness to accept a composite Signature Algorithm MAY be signaled by the use of the SMIMECapabilities Attribute as specified in Section 2.5.2. of [RFC8551] or the SMIMECapabilities certificate extension as specified in [RFC4262].

The intended application for the public key MAY be indicated in the key usage certificate extension as specified in Section 4.2.1.3 of [RFC5280]. If the keyUsage extension is present in a certificate that conveys a composite Signature public key, then the key usage extension MUST contain only the following value:

~~~
digitalSignature
nonRepudiation
keyCertSign
cRLSign
~~~

The keyEncipherment and dataEncipherment values MUST NOT be present. That is, a public key intended to be employed only with a composite signature algorithm MUST NOT also be employed for data encryption. This requirement does not carry any particular security consideration; only the convention that signature keys be identified with 'digitalSignature','nonRepudiation','keyCertSign' or 'cRLSign' key usages.


## SMIMECapabilities Attribute Conventions

Section 2.5.2 of [RFC8551] defines the SMIMECapabilities attribute to announce a partial list of algorithms that an S/MIME implementation can support. When constructing a CMS signed-data content type [RFC5652], a compliant implementation MAY include the SMIMECapabilities attribute.

The SMIMECapability SEQUENCE representing a composite signature Algorithm MUST include the appropriate object identifier as per {{cms-underlying-components}} in the capabilityID field.


# ASN.1 Module {#sec-asn1-module}

~~~ asn.1

<CODE STARTS>

{::include Composite-MLDSA-CMS-2025.asn}

<CODE ENDS>

~~~


# IANA Considerations {#sec-iana}
IANA is requested to allocate a value from the "SMI Security for PKIX Module Identifier" registry [RFC7299] for the included ASN.1 module.

-  Decimal: IANA Assigned - **Replace TBDMOD**
-  Description: Composite-Signatures-CMS-2025 - id-mod-composite-cms-signatures
-  References: This Document


<!-- End of IANA Considerations section -->


# Security Considerations

All security considerations from {{I-D.ietf-lamps-pq-composite-sigs}} apply.


## Use of ctx

TODO



--- back



# Implementation Considerations {#sec-imp-considers}


## Backwards Compatibility {#sec-backwards-compat}

TODO - say something meaningful about backwards compatibility within the CMS context.


<!-- End of Implementation Considerations section -->


# Test Vectors {#appdx-samples}

TODO - Fix this once we have test vectors.



The following test vectors are provided in a format similar to the NIST ACVP Known-Answer-Tests (KATs).

The structure is that a global message `m` is signed over in all test cases. `m` is the ASCII string "The quick brown fox jumps over the lazy dog."
Within each test case there are the following values:

* `tcId` the name of the algorithm.
* `pk` the verification public key.
* `x5c` a self-signed X.509 certificate of the public key.
* `sk` the decapsulation private key.
* `s` the signature value.

Implementers should be able to perform the following tests using the test vectors below:

1. Load the public key `pk` or certificate `x5c` and use it to verify the signature `s` over the message `m`.
2. Validate the self-signed certificate `x5c`.
3. Load the signing private key `sk` and use it to produce a new signature which can be verified using the provided `pk` or `x5c`.

Test vectors are provided for each underlying component in isolation for the purposes of debugging.

Due to the length of the test vectors, you may prefer to retrieve them from GitHub. The reference implementation that generated them is also available:

https://github.com/lamps-wg/draft-composite-sigs/tree/main/src

# ~~~
# {::include src/testvectors_wrapped.json}
# ~~~


# Intellectual Property Considerations

None.


# Contributors and Acknowledgements

TODO -- update this.


This document borrows text from similar documents, including those referenced below. Thanks go to the authors of those
   documents.  "Copying always makes things easier and less error prone" - [RFC8411].

