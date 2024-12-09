<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"  xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes"/>
   
   <xsl:template match="/">
       <xsl:apply-templates select="//marc:datafield[@tag = '945']"/>
   </xsl:template>
    
    <xsl:template match="//marc:datafield[@tag='945']">
        <xsl:apply-templates select="//marc:subfield/@code[count(preceding-sibling::marc:subfield/@code) &lt; 3]" mode="tables" />
    </xsl:template>
    <xsl:template match="//marc:subfield/@code" >
        <xsl:value-of select="text()"/>
    </xsl:template>
    
    <xsl:template match="marc:subfield/@code" mode="tables">
        <marc:datafield tag="945" ind1=" " ind2=" ">
                        <xsl:apply-templates select="." />
        </marc:datafield>
        <marc:datafield tag="945" ind1=" " ind2=" ">
                        <xsl:apply-templates select="following-sibling::marc:subfield/@code[count(preceding-sibling::marc:subfield/@code) = count(current()/preceding-sibling::marc:subfield/@code) +3]" />
        </marc:datafield>
    </xsl:template>
</xsl:stylesheet>