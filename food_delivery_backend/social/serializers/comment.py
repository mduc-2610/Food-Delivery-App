# comments/serializers.py
from rest_framework import serializers

from social.models import Comment
from social.serializers.image import CommentImageSerializer

from utils.serializers import CustomRelatedModelSerializer
from utils.pagination import CustomPagination

class CommentSerializer(CustomRelatedModelSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.many_related_serializer_class = {
            'comment_images':  CommentImageSerializer,
        }

    comment_images = serializers.SerializerMethodField()
    def get_comment_images(self, obj):
        queryset = obj.comment_images.all()
        paginator = CustomPagination(page_size_query_param="image_page_size")  
        page = paginator.paginate_queryset(
            request=self.request, queryset=queryset)
        return CommentImageSerializer(page, many=True).data

    class Meta:
        model = Comment
        fields = '__all__'
