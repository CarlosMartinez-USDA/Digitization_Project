<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="xml" indent="yes" exclude-result-prefixes="marc math xs"/>
   
    <xsl:key name="datafields-by-subfields" match="marc:datafield[@tag='945']" use="marc:subfield[@code='a']| marc:subfield[@code='v']|marc:subfield[@code='p']" />
    <xsl:template match="marc:record">
        <xsl:for-each select="marc:datafield[@tag='945'][count(. | key('datafields-by-subfields', marc:subfield[@code])[1]) = 1]">
            <xsl:sort select="marc:subfield[@code]" />
            <xsl:value-of select="marc:subfield[@code]"/>,<br /><br/>,<br />
            <xsl:for-each select="key('datafields-by-subfields', marc:subfield[@code])">
                <xsl:sort select="marc:subfield[@code]"/>
                <xsl:value-of select="marc:subfield[@code]" />
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="marc:record">
        <xsl:for-each select="marc:datafield[@tag='945'][generate-id() = generate-id(key('datafields-by-subfields', marc:subfield[@code])[1])]">
            <xsl:sort select="marc:subfield[@code]" />
            <xsl:copy-of select="marc:subfield[@code]"/>           
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>