
from rest_framework.throttling import SimpleRateThrottle

class CustomThrottle(SimpleRateThrottle):

    def parse_rate(self, rate):
        if rate is None:
            return (None, None)
        num, period = rate.split('/')
        num_requests = int(num)
        
        duration = None
        if period[0].isdigit():    
            unit_of_time = {'s': 1, 'm': 60, 'h': 3600, 'd': 86400}[period[-1]]
            amount_of_time =  int(period[:-1])
            duration =  amount_of_time * unit_of_time
        else:        
            duration = {'s': 1, 'm': 60, 'h': 3600, 'd': 86400}[period[0]]
            
        return (num_requests, duration)
    
    def get_cache_key(self, request, view):
        if request.user.is_authenticated:
            ident = request.user.pk
        else:
            ident = self.get_ident(request)

        return self.cache_format % {
            'scope': self.scope,
            'ident': ident
        }

