from celery import shared_task
from django.utils import timezone
from order.models import DeliveryRequest
import logging

logger = logging.getLogger(__name__)

@shared_task
def check_and_expire_requests():
    now = timezone.now()
    expired_requests = DeliveryRequest.objects.filter(status='PENDING', expired_at__lt=now)
    print("ABC", pretty=True)
    logger.info(f"Found {expired_requests.count()} expired requests.")
    
    for request in expired_requests:
        logger.info(f"Expiring request {request.id}")
        request.expire()
