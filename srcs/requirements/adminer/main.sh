#!/bin/ash

set -eu

wget https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php
mv adminer-5.4.1.php /website/wordpress/adminer.php
