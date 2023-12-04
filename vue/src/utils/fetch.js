const fetch = async (event, data) => {
    try {
        const head = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(data),
        };

        const resourceName = window.GetParentResourceName();

        const response = await fetch(`https://${resourceName}/${event}`, head);
        
        if (!response.ok) {
            throw new Error(`Unable to fetch ${event}! Status: ${response.status}`);
        }

        const resData = await response.json();
        return resData;
    } catch (error) {
        console.error(error);
    }
}

export default fetch;


