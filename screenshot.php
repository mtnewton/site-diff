<?php

require __DIR__ . '/vendor/autoload.php';

use Spatie\Browsershot\Browsershot;

$outputPath = __DIR__ . '/output';

Browsershot::url($argv[1])->noSandbox()->fullPage()->waitUntilNetworkIdle()->delay(1000)->timeout(999)->save($outputPath . '/A.png');
Browsershot::url($argv[2])->noSandbox()->fullPage()->waitUntilNetworkIdle()->delay(1000)->timeout(999)->save($outputPath . '/B.png');

$diff = exec("compare -metric mae -compose src $outputPath/A.png $outputPath/B.png $outputPath/Diff.png 2>&1", $_, $status);



if ($status) {
    trigger_error('Sites are different or there was an error: ' . $diff, E_USER_ERROR);
}

