<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.loc.gov/MARC21/slim"
    xmlns:f="http://functions"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://www.loc.org/namespace" exclude-result-prefixes="xlink marc" version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="group-945"/>
    <xsl:strip-space elements="*"/>
    <xsl:include href="NAL-MARC21slimUtils.xsl"/>
    
    
    <a name="hr_1" id="hr">
        <text>11</text>
    </a>
    <a name="hr_2" id="hr">
        <text>12</text>
    </a>
    
    <a name="hre_1" id ="hre">
        <text>11</text>
    </a>
    <a name="hre_2" id ="hre">
        <text>12</text>
    </a>
    expected output:The transformed output is expected like below
    
    <b name ="hr">
        <value>11</value>
        <value>12</value>
    </b>
    
    <b name ="hre">
        <value>11</value>
        <value>12</value>
    </b>
   
    <xsl:template match="marc:datafield[@tag='945']">
        <xsl:copy>
            <xsl:for-each-group select="a" group-by="substring-before(@name, '_')">
                <b name="{current-grouping-key()}">
                    <xsl:copy-of select="current-group()/*"/>
                </b>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>