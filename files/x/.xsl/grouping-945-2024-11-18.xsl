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
            <xsl:copy-of xml:space="preserve" select="marc:datafield[@tag &lt; '945']"/>
            <xsl:call-template name="datafield"/>
            <xsl:copy-of xml:space="preserve" select="marc:datafield[@tag > '945']"/>
        </marc:record>            
    </xsl:template>
    <!--    <xsl:template match="marc:datafield[@tag='945'][not(marc:subfield[@code='a'['Digimet'] or @code='p' or @code='v'])]"/>-->
    
    <xsl:template name="datafield">
        <xsl:apply-templates select="marc:datafield[@tag = '945']" mode="#default"/>
        <xsl:apply-templates select="marc:datafield[@tag = '945']" mode="group-945"/> 
    </xsl:template>
    
    <xsl:template match="marc:datafield[@tag = '945']" mode="group-945">
        <xsl:for-each-group select="*" group-by="descendant::node()">
            <xsl:apply-templates select="../marc:subfield[@code]" mode="subfield"/>
        </xsl:for-each-group>
    </xsl:template>
    
    
    <xsl:template match="marc:subfield[@code]" mode="subfield">
        <xsl:variable name="atomic" select="current-grouping-key()"/>
        <xsl:variable name="newNode">
            <xsl:element name="node">
                <xsl:value-of select="$atomic"/>
            </xsl:element>
        </xsl:variable>
        <xsl:for-each select="current-grouping-key()">
        <marc:subfield code="{../marc:subfield/@code[name()]}">
            <xsl:copy-of select="f:subfieldSelect($newNode,../marc:subfield/@code[name()])"/>
        </marc:subfield>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
