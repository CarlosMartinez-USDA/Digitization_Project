<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.loc.gov/MARC21/slim" xmlns:f="http://functions" xmlns:local="http://www.loc.org/namespace" xmlns:math="http://www.w3.org/2005/xpath-functions" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="f local math marc xd xlink xs xsi">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="group-945"/>
    <xsl:strip-space elements="*"/>
    
         <xsl:template match="marc:record">
             <marc:datafield  tag="945" ind1=" " ind2=" ">
             <xsl:apply-templates select="marc:datafield[@tag='945']" mode="unwrap945"/>
             </marc:datafield>
         </xsl:template>
   
    
    <!-- Template to match the parent node -->
    <xsl:template match="marc:datafield[@tag='945']/marc:subfield[@code]" mode="unwrap945">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <!-- Unwrap the child node -->
            <xsl:apply-templates select="marc:subfield[@code]" mode="rewrap945"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="marc:datafield[@tag='945']">
        <xsl:copy-of select="node()"/>
    </xsl:template>
    
    <!-- Template to match the child node and rewrap it -->
    <xsl:template match="marc:subfield[@code]" mode="rewrap945">
        <xsl:copy>              
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>