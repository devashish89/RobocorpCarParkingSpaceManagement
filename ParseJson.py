# +
import json
import cv2

# content='[{"boxes": [300.19, 157.28, 162.88, 67.53], "scores": 0.83, "labels": "car"}, {"boxes": [179.85, 153.54, 118.94, 71.73], "scores": 0.77, "labels": "car"}, {"boxes": [181.91, 282.44, 132.54, 93.82], "scores": 0.74, "labels": "car"}, {"boxes": [299.63, 280.51, 190.84, 91.95], "scores": 0.73, "labels": "car"}, {"boxes": [41.76, 122.76, 98.28, 105.69], "scores": 0.72, "labels": "car"}]'

def bounding_box_object(filepath, json_content):
    lst = json.loads(json_content)
#     print(lst)
    image = cv2.imread(filepath)
    
    for item in lst:
        print(item)
        print(item['boxes'])

        # Using cv2.rectangle() method
        # Draw a rectangle with blue line borders of thickness of 2 px
        # image = cv2.rectangle(image, start_point, end_point, color, thickness)
        x,y,w,h = tuple(item['boxes'])

        img1=cv2.rectangle(image, (int(x), int(y)), (int(x+w), int(y+h)), (255, 0, 0), 2)
        cv2.putText(img1, str(item['scores']), (int(x), int(y-10)), cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.8, (0, 0, 255), 2)


        cv2.imwrite(filepath,img1)
    
    return len(lst)



    
