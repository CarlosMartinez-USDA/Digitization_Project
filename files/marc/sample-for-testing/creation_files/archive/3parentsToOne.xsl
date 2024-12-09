<xsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="marc:record">
        <xsl:copy>
            <marc:datafield tag="945" ind1=" " ind2=" ">
                <xsl:apply-templates select="marc:datafield[@tag='945']/marc:subfield[@code='a']"/>
                <xsl:apply-templates select="marc:datafield[@tag='945']/marc:subfield[@code='v']"/>
                <xsl:apply-templates select="marc:datafield[@tag='945']/marc:subfield[@code='p']"/>
            </marc:datafield>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="marc:subfield[@code]">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>