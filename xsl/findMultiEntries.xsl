<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output
        method="text"/>
    <xsl:template
        match="/">
        <xsl:apply-templates
            mode="overview"
            select="//tei:ab"/>
    </xsl:template>
    <xsl:template
        match="tei:ab"
        mode="overview">
        <xsl:choose>
            <xsl:when
                test="count(tei:placeName) > 1">
                <xsl:variable
                    name="ref">
                    <xsl:value-of
                        select="ancestor::tei:div[@type = 'face']/@n"/>
                    <xsl:text>.</xsl:text>
                    <xsl:value-of
                        select="parent::tei:div/@n"/>
                    <xsl:text>.</xsl:text>
                    <xsl:value-of
                        select="./@n"/>
                </xsl:variable>
                
                <xsl:value-of select="$ref"></xsl:value-of>
                <xsl:apply-templates
                    mode="cite"
                    select="tei:placeName"/>
                <xsl:text>
</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template
        match="tei:placeName"
        mode="cite">
        <xsl:text>#</xsl:text>
        <xsl:value-of
            select="./@n"/>
    </xsl:template>
    <xsl:template
        match="tei:ab"
        mode="place">
        <xsl:value-of
            select="ancestor::tei:div[@type = 'face']/@n"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of
            select="parent::tei:div/@n"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of
            select="./@n"/>
    </xsl:template>
    <xsl:template
        match="tei:ab"
        mode="amount">
        <xsl:text>=</xsl:text>
        <xsl:apply-templates
            select="descendant::tei:measure"/>
    </xsl:template>
    <xsl:template
        match="tei:measure">
        <xsl:apply-templates
            select="tei:num"/>
    </xsl:template>
    <xsl:template
        match="tei:num">
        <xsl:value-of
            select="./@value"/>
    </xsl:template>
    <xsl:template
        match="tei:placeName">
        <xsl:if
            test="./@n">
            <xsl:apply-templates
                mode="place"
                select="ancestor::tei:ab"/>
            <xsl:text>=</xsl:text>
            <xsl:choose>
                <xsl:when
                    test="./@ana">
                    <!--<xsl:value-of select="./@ana"></xsl:value-of>-->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="./@n"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>=</xsl:text>
            <xsl:variable
                name="raw"
                select="."/>
            <xsl:variable
                name="tidy"
                select="translate($raw,'&#x0A;',' ')"/>
            <xsl:value-of
                select="$tidy"/>
            <xsl:apply-templates
                mode="amount"
                select="ancestor::tei:ab"/>
            <xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
