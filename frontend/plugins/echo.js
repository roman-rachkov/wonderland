export default function ({$echo}){
  console.log($echo);
  $echo.connector.options.host = window.location.hostname + ':6001';

}
