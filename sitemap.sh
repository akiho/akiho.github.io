#!/bin/bash
: ${cd:=.} ${URL:="https://ten.j-j.net/"}

IFS=$'\r\n'
GLOBIGNORE='*'
OPTIONS=(
-prune
! -iname CNAME
! -iname robots.txt
! -iname sitemap.\*
! -iname \*.yml
! -iname \*.xml
! -iname \*.md
! -iname .\*
! -path ./_layouts/\*
! -path ./.git/\*
! -path ./css/\*
! -path ./js/\*
! -path ./img/\*
! -path ./tmp/\*
! -path ./fonts/\*
! -path ./stats/\*
)

cat <<HEADER
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
HEADER

cd $cd

find . -type f "${OPTIONS[@]}" -printf "%TY-%Tm-%Td%p\n" | \
while read -r line; do
cat << ITEM
<url>
	<loc>${URL}${line:12}</loc>
	<lastmod>${line:0:10}</lastmod>
	<changefreq>weekly</changefreq>
	<priority>0.5</priority>
</url>
ITEM
done

cat <<FOOTER
</urlset>
FOOTER
