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
            foreach ($this->patterns as $pattern) {
                if (fnmatch($pattern, $source->relativePathname())) {
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
