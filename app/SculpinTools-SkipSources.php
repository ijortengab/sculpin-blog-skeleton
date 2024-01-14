<?php

namespace SculpinTools;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Sculpin\Core\Event\SourceSetEvent;
use Sculpin\Core\Sculpin;

final class SkipSources implements EventSubscriberInterface
{
    /**
     * @var string[]
     */
    private $patterns = [];

    public function __construct(array $patterns)
    {
        $this->patterns = $patterns;
    }

    public function skipSourcesMatchingPattern(SourceSetEvent $event): void
    {
        foreach ($event->allSources() as $source) {
            $a = $source->relativePathname();
            // $debugname = 'a'; $debugvariable = '|||wakwaw|||'; if (array_key_exists($debugname, get_defined_vars())) { $debugvariable = $$debugname; } elseif (isset($this) && property_exists($this, $debugname)){ $debugvariable = $this->{$debugname}; $debugname = '$this->' . $debugname; } if ($debugvariable !== '|||wakwaw|||') {        echo "\r\n<pre>" . basename(__FILE__ ). ":" . __LINE__ . " (Time: " . date('c') . ", Direktori: " . dirname(__FILE__) . ")\r\n". 'var_dump(' . $debugname . '): '; var_dump($debugvariable); echo "</pre>\r\n"; }
            foreach ($this->patterns as $pattern) {
                // $debugname = 'pattern'; $debugvariable = '|||wakwaw|||'; if (array_key_exists($debugname, get_defined_vars())) { $debugvariable = $$debugname; } elseif (isset($this) && property_exists($this, $debugname)){ $debugvariable = $this->{$debugname}; $debugname = '$this->' . $debugname; } if ($debugvariable !== '|||wakwaw|||') {        echo "\r\n<pre>" . basename(__FILE__ ). ":" . __LINE__ . " (Time: " . date('c') . ", Direktori: " . dirname(__FILE__) . ")\r\n". 'var_dump(' . $debugname . '): '; var_dump($debugvariable); echo "</pre>\r\n"; }

                if (fnmatch($pattern, $source->relativePathname())) {
                    // $debugname = 'a'; $debugvariable = '|||wakwaw|||'; if (array_key_exists($debugname, get_defined_vars())) { $debugvariable = $$debugname; } elseif (isset($this) && property_exists($this, $debugname)){ $debugvariable = $this->{$debugname}; $debugname = '$this->' . $debugname; } if ($debugvariable !== '|||wakwaw|||') {        echo "\r\n<pre>" . basename(__FILE__ ). ":" . __LINE__ . " (Time: " . date('c') . ", Direktori: " . dirname(__FILE__) . ")\r\n". 'var_dump(' . $debugname . '): '; var_dump($debugvariable); echo "</pre>\r\n"; }
                    // $debugname = 'pattern'; $debugvariable = '|||wakwaw|||'; if (array_key_exists($debugname, get_defined_vars())) { $debugvariable = $$debugname; } elseif (isset($this) && property_exists($this, $debugname)){ $debugvariable = $this->{$debugname}; $debugname = '$this->' . $debugname; } if ($debugvariable !== '|||wakwaw|||') {        echo "\r\n<pre>" . basename(__FILE__ ). ":" . __LINE__ . " (Time: " . date('c') . ", Direktori: " . dirname(__FILE__) . ")\r\n". 'var_dump(' . $debugname . '): '; var_dump($debugvariable); echo "</pre>\r\n"; }
                    $source->setShouldBeSkipped();
                    
                }
            }
        }
    }

    public static function getSubscribedEvents(): array
    {
        return [
            Sculpin::EVENT_BEFORE_RUN => ['skipSourcesMatchingPattern']
        ];
    }
}
