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
  <!-- <xsl:variable name="pos">
       <xsl:variable name="i" select="2" />
        <xsl:for-each select="marc:collection/marc:record/marc:datafield[@tag='945']">
        <xsl:variable name="i" select="$i + 1" />
        <!-\- DO SOMETHING -\->
        </xsl:for-each>
    </xsl:variable>-->
    <xsl:template match="marc:record">
        <marc:record>
            <xsl:copy-of xml:space="preserve" select="marc:leader"/>
            <xsl:copy-of xml:space="preserve" select="marc:controlfield"/>
            <xsl:copy-of select="marc:datafield except marc:datafield[@tag>='945']"/>
            <xsl:apply-templates select="marc:datafield[@tag='945']" mode="group-945"/>
<!--            <xsl:apply-templates select="marc:datafield[@tag='945']" mode="group-945"/>-->
            <xsl:call-template name="marcField945"/>
            <xsl:copy-of select="marc:datafield[@tag > '945']"/>
        </marc:record>            
    </xsl:template>
    
    
 <!--   <xsl:template match='@* | node()'>
        <xsl:copy>
            <xsl:copy-of select='@* | node()'/>
        </xsl:copy>
    </xsl:template>-->
    
    
    <xsl:template match="marc:datafield[@tag = '945']" mode="group-945">
<!--        <xsl:choose>-->
<!--        <xsl:when test="marc:datafield[@tag = '945'][1]"/>-->
      
<!--      <xsl:when test="marc:datafield[@tag = '945']">          -->
        <xsl:copy-of select=""/>
          <marc:datafield tag="945" ind1=" " ind2=" ">
            <xsl:for-each-group select="." group-by="descendant::node()">
<!--                <marc:subfield code="{attribute()}">                    -->
                 <xsl:copy-of select="marc:subfield"/>
<!--                </marc:subfield>-->
             </xsl:for-each-group>             
          </marc:datafield>
      <!--</xsl:when>-->
        <!--</xsl:choose>-->
        
    </xsl:template>
    
    <xsl:template name="marcField945">      
        <xsl:for-each-group select="marc:datafield[@tag = '945'][position() > 1]" group-by="descendant::node()">
                          
            <xsl:for-each select="current-group()">
               <xsl:apply-templates select="marc:subfield"/>
            </xsl:for-each>
            
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="marc:subfield">
        <xsl:copy-of select="f:subfieldSelect(current-group(),'apv')"/>        
    </xsl:template>
</xsl:stylesheet>