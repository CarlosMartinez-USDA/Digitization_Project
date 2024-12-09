<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.loc.gov/MARC21/slim" xmlns:f="http://functions"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://www.loc.org/namespace" exclude-result-prefixes="xlink marc" version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="group-945"/>
    <xsl:strip-space elements="*"/>
    <xsl:include href="NAL-MARC21slimUtils.xsl"/>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <xsl:result-document version="1.0" encoding="utf-8" format="group-945"
            href="{replace(base-uri(),'(.*/)(.*)(\.xml)','$1')}N-{replace(base-uri(), '(.*/)(.*)(\.xml)','$2')}_{position()}.xml">
            <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                <xsl:apply-templates select="//marc:record"/>
            </marc:collection>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="marc:record">
        <marc:record>
        <xsl:copy-of xml:space="preserve" select="marc:leader"/>
        <xsl:copy-of xml:space="preserve" select="marc:controlfield"/>
            <xsl:copy-of select="marc:datafield except marc:datafield[@tag>='945']"/>
        <marc:datafield tag="945" ind1=" " ind2=" ">
            <xsl:apply-templates select="marc:datafield[@tag='945']" mode="group-945"/>
        </marc:datafield>
        <xsl:copy-of select="marc:datafield[@tag > '945']"/>
        </marc:record>            
    </xsl:template>
    
    <xsl:template match="marc:datafield[@tag = '945']" mode="group-945">      
        <xsl:for-each-group select="*" group-by="position()">
            <xsl:variable name="i" select="current-grouping-key()"/>
                  <xsl:copy-of select="current-grouping-key()"/>
<!--            <xsl:apply-templates select="//marc:subfield[@code]"/>-->
       
<!--    </xsl:template>
    
    
    <xsl:template match="marc:subfield[@code]">
-->        <xsl:for-each-group select="../marc:subfield[@code]" group-by="marc:datafield[position()=$i]">
            <xsl:sort select="." data-type="text" order="ascending"/>
            <xsl:value-of select="current-group()"/>
        </xsl:for-each-group>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
