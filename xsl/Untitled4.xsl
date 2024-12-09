<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.loc.gov/MARC21/slim" xmlns:f="http://functions"
    xmlns:local="http://www.loc.org/namespace" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="f local marc xd xlink xs xsi">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="group-945"/>
    <xsl:strip-space elements="*"/>
    
    <xd:doc id="group-945.xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Original author: </xd:b>Carlos Martinez III</xd:p>
            <xd:p><xd:b>Created on: </xd:b>November 18, 2024</xd:p>
            <xd:p><xd:b>Modified by: </xd:b>Carlos Martinez</xd:p>
            <xd:p><xd:b>Date last modified: </xd:b>November 18, 2024</xd:p>
            <xd:p><xd:b>Purpose: </xd:b>This stylesheet was created to concatenate marc subfields
                "a" "p" and "v" with a local datafield, "945".</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:include href="NAL-MARC21slimUtils.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    
    <xd:doc id="root" scope="component">
        <xd:desc>
            <xd:p>Build MODS document</xd:p>
        </xd:desc>
    </xd:doc>
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
            <xsl:copy-of select="marc:datafield[@tag &lt; '945']"/>
            <xsl:if
                test="marc:datafield[@tag = '945']/marc:subfield[1][@code = 'd' or @code = 'e' or @code = 'f' or @code = 'g' or @code = 'n']">
                <marc:datafield tag="945" ind1=" " ind2=" ">
                    <xsl:apply-templates select="marc:datafield[@tag = '945']" mode="#default"/>
                </marc:datafield>
            </xsl:if>
            <xsl:copy>
                <marc:datafield tag="945" ind1=" " ind2=" ">
                    <xsl:for-each select="marc:datafield[@tag]">
                        <xsl:apply-templates select="marc:datafield[@tag='945']/marc:subfield[@code='a']"/>
                        <xsl:apply-templates select="marc:datafield[@tag='945']/marc:subfield[@code='v']"/>
                        <xsl:apply-templates select="marc:datafield[@tag='945']/marc:subfield[@code='p']"/>
                    </xsl:for-each>
                </marc:datafield>
            </xsl:copy>
            
            <xsl:copy-of xml:space="preserve" select="marc:datafield[@tag > '945']"/>
        </marc:record>
    </xsl:template>
    
    
    
    
    <xsl:template match="marc:subfield[@code]">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="marc:datafield[@tag = '945']" mode="group-945">
        <xsl:for-each-group select="*" group-by="descendant::node()">
            <xsl:apply-templates
                select="../marc:subfield[@code = 'a' or @code = 'p' or @code = 'v']" mode="subfield">
                <xsl:sort order="ascending" select="@*"/>
                <xsl:with-param name="subfieldCode" select="@*"/>
            </xsl:apply-templates>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="marc:datafield[@tag = '945']" mode="#default">
        <xsl:for-each-group select="*" group-by="descendant::node()">
            <xsl:apply-templates
                select="../marc:subfield[1][@code = 'd' or @code = 'e' or @code = 'f' or @code = 'g' or @code = 'n']"
                mode="subfield">
                <xsl:sort order="descending" select="@*"/>
                <xsl:with-param name="subfieldCode" select="@*"/>
            </xsl:apply-templates>
        </xsl:for-each-group>
    </xsl:template>
    
    
    
    <xsl:template match="//marc:subfield[@code]" mode="subfield">
        <xsl:param name="subfieldCode"/>
        <xsl:variable name="atomic" select="current-grouping-key()"/>
        <xsl:variable name="newNode">
            <xsl:element name="node">
                <xsl:value-of select="$atomic"/>
            </xsl:element>
        </xsl:variable>
        <xsl:for-each select="$newNode">
            <marc:subfield code="{$subfieldCode}">
                <xsl:copy-of select="f:subfieldSelect($newNode, $subfieldCode)"/>
            </marc:subfield>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
