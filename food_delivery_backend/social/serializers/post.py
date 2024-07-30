from rest_framework import serializers

from social.models import Post

from social.serializers import PostImageSerializer

from utils.serializers import CustomRelatedModelSerializer
from utils.pagination import CustomPagination

class PostSerializer(CustomRelatedModelSerializer):
    post_images = serializers.SerializerMethodField()

    def get_post_images(self, obj):
        queryset = obj.post_images.all()
        paginator = CustomPagination(page_size_query_param="image_page_size")  
        page = paginator.paginate_queryset(
            request=self.request, queryset=queryset)
        return PostImageSerializer(page, many=True).data
    
    class Meta:
        model = Post
        fields = ['id', 'user', 'title', 'content', 'post_images', 'created_at']

class DetailPostSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.many_related_serializer_class = {
            # 'post_images': {
            #     'serializer': PostImageSerializer,
            #     'context': {'detail': True}
            # },
        }

    class Meta:
        model = Post
        # fields = ['id', 'user', 'post_images', 'title', 'content', 'created_at']
        fields = ['id']
