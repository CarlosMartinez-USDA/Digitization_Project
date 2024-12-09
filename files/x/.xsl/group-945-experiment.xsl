<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.loc.gov/MARC21/slim" xmlns:f="http://functions"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://www.loc.org/namespace" exclude-result-prefixes="xlink marc" version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="group-945"/>
    <xsl:strip-space elements="*"/>
    <xsl:include href="NAL-MARC21slimUtils.xsl"/>

    <xsl:template match="/">
        <xsl:result-document version="1.0" encoding="utf-8" format="group-945"
            href="{replace(base-uri(),'(.*/)(.*)(\.xml)','$1')}N-{replace(base-uri(), '(.*/)(.*)(\.xml)','$2')}_{position()},xml">
            <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                <xsl:apply-templates select="marc:datafield[@tag='945']"/>
            </marc:collection>
        </xsl:result-document>
    </xsl:template>
  
    <xsl:template match="marc:datafield[@tag='945']">
            <xsl:for-each-group select="."  group-ending-with="tokenzie(marc:datafield[@tag=''],'p|v')[last()]">
            <xsl:if test="marc:subfield[@code='a']"><marc:subfield code="a"><xsl:value-of select="f:subfieldSelect(.,'a')"/></marc:subfield></xsl:if>
            <xsl:if test="marc:subfield[@code='p']"><marc:subfield code="p"><xsl:value-of select="f:subfieldSelect(.,'p')"/></marc:subfield></xsl:if>
            <xsl:if test="marc:subfield[@code='v']"><marc:subfield code="v"><xsl:value-of select="f:subfieldSelect(.,'v')"/></marc:subfield></xsl:if>
            </xsl:for-each-group>
        
        
    </xsl:template>       
        
        <!--   <xsl:for-each-group select="marc:subfield[@code='a']" group-by="position()">
           <xsl:variable name="i" select="current-grouping-key()"/>
<!-\-           <xsl:for-each-group select="self::node() or following-sibling::node() >-\->
           <xsl:for-each-group select="../following-sibling::marc:subfield[@code='a' or@code='p' or @code='v']" group-by="marc:subfield[position()=$i]">
               <sub
               <xsl:value-of select=""
           </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="marc:subfield[@code = 'a' or @code = 'p' or @code = 'v']" mode="group-945">
        <xsl:param name="codes">
            <xsl:for-each select="$codes">
            <xsl:variable name="code" select="tokenize($codes, 'apv')"    
                <xsl: 
            </xsl:for-each>
            <xsl:for-each select="f:subfieldSelect(parent::*, 'apv')">
                <marc:subfield>
                    <xsl:attribute name="code" select="$codes"/>
                    <xsl:value-of select="."/>
                </marc:subfield>
            </xsl:for-each>
            
        </xsl:param>
        
    </xsl:template>
-->
    <!--    <xsl:template match="marc:subfield[@code='a' or @code='p' or @code='v']" mode="group-945">-->
    <!--<xsl:template name="group-945">
      <xsl:param name="subfieldSelect"/>
    <xsl:for-each-group select="$subfieldSelect" group-by="marc:datafield">
            <xsl:variable name="i" select="current-grouping-key()"/>
           <xsl:for-each-group select="../following-sibling::node()" group-adjacent="marc:subfield[position()=$i]">
                   <xsl:value-of select="current-grouping-key()"/>
            </xsl:for-each-group>
            <!-\-</xsl:for-each-group>-\->
        </xsl:for-each-group>-->
    <!--</xsl:template>-->
    <!--      <xsl:template match="marc:subfield[@code='p' or @code='v']">
      
   
    </xsl:template>-->
</xsl:stylesheet>
