#!/bin/bash
: ${f:=${*:-*}}${URL:="https://ten.j-j.net/"}

cat <<HEADER
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
HEADER

find $f -mindepth 1 -not -iname '.git' -print | while read -r f; do
l="$(git log --pretty="%ai $f" -1 HEAD -- $f)"
cat << ITEM
<url>
	<loc>${URL}${l:26}</loc>
	<lastmod>${l:0:10}</lastmod>
	<changefreq>weekly</changefreq>
	<priority>0.5</priority>
</url>
ITEM
done

cat <<FOOTER
</urlset>
FOOTER
