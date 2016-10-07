#!/bin/bash
########################################################################################################################
# NodeJs Repo
########################################################################################################################
curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
        nodejs \
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )
    
########################################################################################################################
# Node Stuff
########################################################################################################################
echo 'export PATH="$PATH:/usr/local/.npm/bin"' >> /etc/profile
export PATH="$PATH:/usr/local/.npm/bin"
npm config --global set prefix '/usr/local/.npm'
npm install --global --quiet gulp
npm install --global --quiet bower
npm install --global --quiet eslint
npm install --global --quiet uglifycss
npm install --global --quiet uglify-js

########################################################################################################################
# CI Stuff
########################################################################################################################
echo 'export COMPOSER_HOME="/usr/local/.composer"' >> /etc/profile
export COMPOSER_HOME="/usr/local/.composer"

wget --no-clobber --quiet https://symfony.com/installer --output-document=/usr/local/bin/symfony \
    && chmod a+x /usr/local/bin/symfony 
wget --no-clobber --quiet https://getcomposer.org/download/1.2.0/composer.phar --output-document=/usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer \
    && composer --quiet --ansi global require hirak/prestissimo
wget --no-clobber --quiet https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.6.2/phpcs.phar --output-document=/usr/local/bin/phpcs \
    && chmod a+x /usr/local/bin/phpcs 
wget --no-clobber --quiet https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.6.2/phpcbf.phar --output-document=/usr/local/bin/phpcbf \
    && chmod a+x /usr/local/bin/phpcbf 
wget --no-clobber --quiet http://get.sensiolabs.org/php-cs-fixer-v1.11.6.phar --output-document=/usr/local/bin/php-cs-fixer \
    && chmod a+x /usr/local/bin/php-cs-fixer 
wget --no-clobber --quiet https://phar.phpunit.de/phpunit-5.4.6.phar --output-document=/usr/local/bin/phpunit \
    && chmod a+x /usr/local/bin/phpunit 
wget --no-clobber --quiet http://static.phpmd.org/php/2.4.3/phpmd.phar --output-document=/usr/local/bin/phpmd \
    && chmod a+x /usr/local/bin/phpmd 
wget --no-clobber --quiet https://phar.phpunit.de/phpcpd-2.0.4.phar --output-document=/usr/local/bin/phpcpd \
    && chmod a+x /usr/local/bin/phpcpd 
wget --no-clobber --quiet http://get.sensiolabs.de/deptrac.phar --output-document=/usr/local/bin/deptrac \
    && chmod a+x /usr/local/bin/deptrac 
wget --no-clobber --quiet https://github.com/phpmetrics/PhpMetrics/raw/v1.10.0/build/phpmetrics.phar --output-document=/usr/local/bin/phpmetrics \
    && chmod a+x /usr/local/bin/phpmetrics 
wget --no-clobber --quiet http://robo.li/robo.phar --output-document=/usr/local/bin/robo \
    && chmod a+x /usr/local/bin/robo 
wget --no-clobber --quiet https://padraic.github.io/humbug/downloads/humbug.phar --output-document=/usr/local/bin/humbug.phar \
    && echo 'php -dzend_extension=xdebug.so /usr/local/bin/humbug.phar' > /usr/local/bin/humbug \
    && chmod a+x /usr/local/bin/humbug \
    && wget --no-clobber --quiet https://padraic.github.io/humbug/downloads/humbug.phar.pubkey  --output-document=/usr/local/bin/humbug.phar.pubkey
wget --no-clobber --quiet http://pharchive.phmlabs.com/archive/phmLabs/Smoke/current/Smoke.phar --output-document=/usr/local/bin/smoke \
    && chmod a+x /usr/local/bin/smoke 
#wget --no-clobber --quiet  --output-document=/usr/local/bin/ \
#    && chmod a+x /usr/local/bin/ 

chmod -R a+rwx /usr/local/.composer/cache
