


class TaskEngine:
    def get_task_view_url(self,task_instance):
        return None
    def get_submission_view_url(self,submission_instance):
        return None
    def get_thumbnail_url(self,submission_instance):
        return None

    def on_submit(self,submission):
        return None
    def on_approval(self,submission):
        return None
    def on_rejection(self,submission):
        return None
    def on_deactivate(self,submission):
        return None

    def get_submission_xml(self,submission):
        return ""
