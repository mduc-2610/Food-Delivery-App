
from rest_framework import response, \
                            pagination

from rest_framework import pagination

class CustomPagination(pagination.PageNumberPagination):
    def __init__(
            self, 
            page_size=10, 
            max_page_size=10000, 
            page_query_param="page",
            page_size_query_param="page_size",
            max_page_size_query_param="max_page_size"
        ):
        super().__init__()
        self.page_size = page_size
        self.max_page_size = max_page_size
        self.page_query_param = page_query_param
        self.page_size_query_param = page_size_query_param  
        self.max_page_size_query_param = max_page_size_query_param


    def get_paginated_response(self, data):
        return response.Response({
            'pagination': {
                'next': self.get_next_link(),
                'previous': self.get_previous_link(),
                'total_pages': self.page.paginator.num_pages,
                'current_page': self.page.number,
                'count': self.page.paginator.count
            },
            'results': data
        })