class FilterStrategyList {
  static final List<String> filters = [
    'Tous',
    'N\'ont pas encore payé',
    'Terminus',
    'Ont payé',
    'Sur route'
  ];

  static String getAllFilterLib() => 'Tous';
  static String getNotPaidFilterLib()=>'N\'ont pas encore payé';
  static String getArrivedFilterLib()=>'Terminus';
  static String getPaidFilterLib()=>'Ont payé';
  static String getOnTheWayFilterLib()=>'Sur route';

  static String getDefault()=> 'Tous';

}