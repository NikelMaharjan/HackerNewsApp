

abstract class NewsEvent{
  const NewsEvent();
}

class FetchStoriesEvent extends NewsEvent{}
class RefreshEvent extends NewsEvent{}