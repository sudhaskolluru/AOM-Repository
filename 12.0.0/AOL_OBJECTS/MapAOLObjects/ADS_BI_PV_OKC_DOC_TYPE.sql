  CREATE OR REPLACE EDITIONABLE VIEW "ADS_BI_PV_OKC_DOC_TYPE" ("DOCUMENT_TYPE", "DOCUMENT_TYPE_CLASS") AS
  select document_type, document_type_class from okc_bus_doc_types_b
 ;
