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
            href="{replace(base-uri(),'(.*/)(.*)(\.xml)','$1')}N-{replace(base-uri(), '(.*/)(.*)(\.xml)','$2')}_{position()},xml">
            <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                <xsl:apply-templates select="//marc:record"/>
            </marc:collection>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//marc:record">
        <marc:datafield tag="945">
            <xsl:for-each select="marc:datafield[@tag='945']">
        <xsl:for-each-group select="marc:datafield[@tag='945']" group-adjacent="marc:subfield">       
            <marc:subfield code="{@code}">
                <xsl:call-template name="join">
                    <xsl:with-param name="subfield" select="marc:subfield[@code = 'a'],marc:subfield[@code = 'p'],marc:subfield[@code = 'v']"/>
                    <xsl:with-param name="separator" select="','"/>
                </xsl:call-template>
            </marc:subfield>      
        </xsl:for-each-group>
            </xsl:for-each>
        </marc:datafield>
    </xsl:template>

    <xsl:template name="join">
        <xsl:param name="subfield"/>
        <xsl:param name="separator"/>

        <xsl:for-each select="$subfield">
            <xsl:attribute name="code" select="if (@code = 'a') then 'a' else if (@code = 'p') then 'p' else if (@code = 'v') then 'v' else ''"/>
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()">
                <xsl:value-of select="$separator"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
